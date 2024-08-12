import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:http/http.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';

/////////////////////////////////////////////////

  Client getClient() {
  return Client();
}

/////////////////////////////////////////////////

  class OrderController extends GetxController {

/////////////////////////////////////////////////

  final PocketBase _pb = PocketBase(
    const String.fromEnvironment('order',
        defaultValue: 'https://saater.liara.run'),
    lang: const String.fromEnvironment('listproductb', defaultValue: 'en-US'),
    httpClientFactory: kIsWeb ? () => getClient() : null,
  );

/////////////////////////////////////////////////

  List<LocationSupplierModel> Datasort = [];

  Timer? _timer; // اضافه کردن تایمر

  @override
  void onInit() {
    super.onInit();
    // شروع تایمر
    _timer = Timer.periodic(Duration(seconds: 15), (timer) async {
      await FetchProductsAndSupplier();
      update(['products']); // به‌روزرسانی GetBuilder با id 'products'
    });
  }

  @override
  void onClose() {
    _timer?.cancel(); // لغو تایمر هنگام بسته شدن کنترلر
    super.onClose();
  }

/////////////////////////////////////////////////

  //final String collectionName = 'location';

  Future<void> updateLocation(LocationUser location, String ides) async {
    try {
      final body = <String, dynamic>{
        "latitude": location.latitude,
        "longitude": location.longitude,
      };

      final record = await _pb.collection('users').update(ides, body: body);
      if (record != null) {
        // Get.snackbar(
        //   'اطلاعات سفارش برنده',
        //   'با موفقیت وارد شد',
        //   backgroundColor: Colors.green,
        //   messageText: Text(
        //     'با موفقیت وارد شد',
        //     textDirection: TextDirection.rtl,
        //   ),
        //   titleText: Text(
        //     'اطلاعات سفارش برنده',
        //     textDirection: TextDirection.rtl,
        //   ),
        // );

        // add(FetchOrders());
        // emit(OrderSuccess('Order updated successfully'));
      } else {
        // emit(OrderError('Failed to update order.'));
        // Get.snackbar(
        //   'اطلاعات سفارش برنده',
        //   'با خطا مواجه شد',
        //   backgroundColor: Colors.red,
        //   messageText: Text(
        //     'با خطا مواجه شد',
        //     textDirection: TextDirection.rtl,
        //   ),
        //   titleText: Text(
        //     'اطلاعات سفارش برنده',
        //     textDirection: TextDirection.rtl,
        //   ),
        // );
      }
    } catch (e) {
      // emit(OrderError(e.toString()));
      Get.snackbar(
        'لطفا اینترنت',
        'تلفن همراه خود را چک کنید',
        backgroundColor: Colors.red,
        messageText: Text(
          'تلفن همراه خود را چک کنید',
          textDirection: TextDirection.rtl,
        ),
        titleText: Text(
          'لطفا اینترنت',
          textDirection: TextDirection.rtl,
        ),
      );
    }
  }

  Future<void> updateProduct(String idProduct) async {
    try {
      final body = <String, dynamic>{
        "expectation": true,
      };




      final record =
      await _pb.collection('listproductb').update(idProduct, body: body);
      if (record != null) {
        Get.snackbar(
          'محصول شما',
          'با موفقیت تایید دریافت شذ',
          backgroundColor: Colors.green,
          messageText: Text(
            'با موفقیت تایید دریافت شذ',
            textDirection: TextDirection.rtl,
          ),
          titleText: Text(
            'محصول شما',
            textDirection: TextDirection.rtl,
          ),
        );
        await FetchProductsAndSupplier();

        // add(FetchOrders());
        // emit(OrderSuccess('Order updated successfully'));
      } else {
        // emit(OrderError('Failed to update order.'));
        await FetchProductsAndSupplier();

        Get.snackbar(
          'محصول شما',
          'با موفقیت تایید دریافت شذ',
          backgroundColor: Colors.green,
          messageText: Text(
            'با موفقیت تایید دریافت شذ',
            textDirection: TextDirection.rtl,
          ),
          titleText: Text(
            'محصول شما',
            textDirection: TextDirection.rtl,
          ),
        );
      }
    } catch (e) {
      // emit(OrderError(e.toString()));
      Get.snackbar(
        'کالای در صف دریافت',
        'با موفقیت دریافت نشد',
        backgroundColor: Colors.red,
        messageText: Text(
          'با موفقیت دریافت نشد',
          textDirection: TextDirection.rtl,
        ),
        titleText: Text(
          'کالای در صف دریافت',
          textDirection: TextDirection.rtl,
        ),
      );
    }
  }

  Future<List<ProductB>> FetchProductsAndSupplier() async {
    int page = 1;
    List<ProductB> products = [];

    try {
      while (true) {
        final resultList = await _pb.collection('listproductb').getList(
          page: page,
          perPage: 50,
          filter: 'expectation = false && okbuy = true',
          expand: 'supplier', // گسترش اطلاعات تامین‌کننده
        );

        if (resultList.items.isEmpty) {
          break;
        }

        for (var productJson in resultList.items) {
          Map<String, dynamic> productData = productJson.toJson();

          // پردازش اطلاعات تامین‌کننده به عنوان یک شیء منفرد به جای لیست
          Supplier? supplier;
          if (productData['expand']?['supplier'] != null) {
            supplier = Supplier.fromJson(
                Map<String, dynamic>.from(productData['expand']['supplier']));
          }

          // ساختن یک محصول جدید با استفاده از داده‌های دریافت شده
          ProductB product = ProductB.fromJson(
            Map<String, dynamic>.from(productData),
            supplier != null ? [supplier] : [],
          );

          products.add(product);
        }

        page++;
      }
    } catch (error) {
      print('Error fetching products: $error');
    }
    await ChangeDate(products);
    return products;
  }

/////////////////////////////////////////////////

  Future<List<LocationSupplierModel>> ChangeDate(List<ProductB> pro) async {
    // نیازی به await برای pro نیست
    List<ProductB> products = pro;
    Map<String, List<ProductListSupplier>> supplierProductsMap = {};

    for (var product in products) {
      print('Product Title: ${product.title}');

      if (product.supplier.isNotEmpty) {
        for (var supplier in product.supplier) {
          print('Supplier ID: ${supplier.id}');
          print('Company Name: ${supplier.companyname}');

          // ساخت ProductListSupplier
          ProductListSupplier productListSupplier = ProductListSupplier(
            IDProduct: product.id,
            title: product.title,
            number: product.number,
            okbuy: product.okbuy,
            hurry: product.hurry,
            expectation: product.expectation,
          );

          // اضافه کردن محصول به لیست محصولات فروشنده در نقشه
          if (!supplierProductsMap.containsKey(supplier.id)) {
            supplierProductsMap[supplier.id] = [];
          }
          supplierProductsMap[supplier.id]!.add(productListSupplier);
        }
      } else {
        print('No suppliers available for this product.');
      }
    }

    List<LocationSupplierModel> newLocations = [];

    // تبدیل نقشه به لیست LocationSupplierModel
    for (var supplierId in supplierProductsMap.keys) {
      var supplier = products
          .expand((product) => product.supplier)
          .firstWhere((sup) => sup.id == supplierId);

      // جدا کردن مقدار طول و عرض جغرافیایی
      List<String> locationParts = supplier.location.split(',');

      if (locationParts.length == 2) {
        double latitude = double.parse(locationParts[0]);
        double longitude = double.parse(locationParts[1]);

        // ساخت LocationSupplierModel جدید و اضافه کردن آن به لیست جدید
        newLocations.add(
          LocationSupplierModel(
            idSupplier: supplier.id,
            position: LatLng(latitude, longitude),
            companyname: supplier.companyname,
            phonenumber: supplier.phonenumber,
            mobilenumber: supplier.mobilenumber,
            address: supplier.address,
            listPS: supplierProductsMap[supplierId]!,
          ),
        );
      }
    }

    print('newLocations: ${newLocations.length}');

    // مقداردهی لیست Datasort
    Datasort = newLocations;
    update(['products']);
    return newLocations;
  }

}

/////////////////////////////////////////////////

  class LocationUser {

  final String latitude;
  final String longitude;

  LocationUser({

    required this.latitude,
    required this.longitude,
  });

  factory LocationUser.fromJson(Map<String, dynamic> json, List<LocationUser> productsA,
      List<ProductB> productsB) {
    return LocationUser(

      latitude: json['latitude'].toString(),
      longitude: json['longitude'].toString(),
    );
  }
}

  class ProductB {
  final String id;
  final String title;
  final String purchaseprice;
  final List<Supplier> supplier;
  final String days;
  final String datecreated;
  final String dataclearing;
  final String number;
  final String description;
  final String datead;
  final bool expectation;
  final bool okbuy;
  final bool hurry;
  final bool official;

  ProductB(
      {required this.title,
        required this.purchaseprice,
        required this.id,
        required this.supplier,
        required this.days,
        required this.datecreated,
        required this.dataclearing,
        required this.number,
        required this.description,
        required this.expectation,
        required this.datead,
        required this.okbuy,
        required this.hurry,
        required this.official});

  factory ProductB.fromJson(
      Map<String, dynamic> json, List<Supplier> suppliers) {
    return ProductB(
      title: json['title'].toString(),
      purchaseprice: json['purchaseprice'].toString(),
      id: json['id'].toString(),
      supplier: suppliers,
      days: json['days'].toString(),
      datecreated: json['datecreated'].toString(),
      dataclearing: json['dataclearing'].toString(),
      number: json['number'].toString(),
      description: json['description'].toString(),
      datead: json['datead'].toString(),
      expectation: json['expectation'],
      okbuy: json['okbuy'],
      hurry: json['hurry'],
      official: json['official'],
    );
  }
}

  class Supplier {
  final String id;
  final String companyname;
  final String phonenumber;
  final String mobilenumber;
  final String address;
  final String location;

  Supplier({
    required this.id,
    required this.companyname,
    required this.phonenumber,
    required this.mobilenumber,
    required this.address,
    required this.location,
  });

  factory Supplier.fromJson(Map<String, dynamic> json) {
    return Supplier(
      id: json['id'] ?? '',
      companyname: json['companyname'] ?? '',
      phonenumber: json['phonenumber'] ?? '',
      mobilenumber: json['mobilenumber'] ?? '',
      address: json['address'] ?? '',
      location: json['location'] ?? '',
    );
  }
}

/////////////////////////////////////////////////

  class ProductListSupplier {
  final String IDProduct;
  final String title;
  final String number;
  final bool okbuy;
  final bool hurry;
  final RxBool expectation;

  ProductListSupplier(
      {required this.IDProduct,
        required this.title,
        required this.number,
        required this.hurry,
        required this.okbuy,
        required bool expectation,  // regular bool passed in constructor
      }) : expectation = RxBool(expectation); // Initialize RxBool
}

  class LocationSupplierModel {
  final List<ProductListSupplier> listPS;
  final String idSupplier;
  final String companyname;
  final String phonenumber;
  final String mobilenumber;
  final String address;
  final LatLng position;

  LocationSupplierModel({
    required this.idSupplier,
    required this.position,
    required this.companyname,
    required this.phonenumber,
    required this.mobilenumber,
    required this.address,
    required this.listPS,
  });
}