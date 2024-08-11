// import 'dart:async';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:pocketbase/pocketbase.dart';
//
// import 'package:http/http.dart';
//
// import 'package:get/get.dart';
//
// Client getClient() {
//   return Client();
// }
//
// class OrderControllerProduct extends GetxController {
//   final PocketBase _pb = PocketBase(
//     const String.fromEnvironment('listproductb',
//         defaultValue: 'https://saater.liara.run'),
//     lang: const String.fromEnvironment('listproductb', defaultValue: 'en-US'),
//     httpClientFactory: kIsWeb ? () => getClient() : null,
//   );
//
//   final String collectionName = 'listproductb';
//
//   List<ProductB> allOrders = []; // جایگزین RxList با لیست معمولی
//
//   late bool isLoading; // استفاده از bool معمولی برای بارگذاری
//   // void insializ() async {
//   //   isLoading = true;
//   //   update(['hi']);
//   //   await fetchAllOrders();
//   //
//   //   isLoading = false;
//   //   update(['hi']);
//   // }
//
//   late Timer _timer; // تایمر برای به روز رسانی هر 10 ثانیه
//
//   @override
//   void onInit() {
//     super.onInit();
//    // insializ();
//     startAutoRefresh(); // شروع به به روز رسانی خودکار در زمان شروع
//   }
//
//   @override
//   void onClose() {
//     super.onClose();
//     _timer.cancel(); // لغو تایمر در زمان بستن کنترلر
//   }
//
//   void startAutoRefresh() {
//     _timer = Timer.periodic(Duration(seconds: 20), (timer) {
//       print('start' + DateTime.now().toString());
//       _fetchAndUpdate(); // صدا زدن متد fetchAllOrders هر 10 ثانیه
//     });
//   }
//
//   Future<void> fetchAllOrders() async {
//     try {
//       isLoading = true; // تنظیم وضعیت بارگذاری به true
//       update(); // به روز رسانی ویجت‌های وابسته
//       List<ProductB> orders = await _fetchOrders();
//       allOrders = orders; // به جای assignAll برای RxList
//     } catch (error) {
//       print('Error fetching orders: $error');
//     } finally {
//       isLoading = false; // تنظیم وضعیت بارگذاری به false
//       update(); // به روز رسانی ویجت‌های وابسته
//     }
//   }
//
//   Future<void> fetchAllOrdersRefresh() async {
//     await _fetchAndUpdate();
//   }
//
//
//
//   Future<void> fetchAllOrdersFilter({String filter = ''}) async {
//     currentFilter = filter;
//     await _fetchAndUpdate();
//   }
//
//
//
//   Future<void> _fetchAndUpdate() async {
//     try {
//       // isLoading = true; // تنظیم وضعیت بارگذاری به true
//       update(); // به روز رسانی ویجت‌های وابسته
//       List<ProductB> orders = await _fetchOrders();
//       allOrders = orders; // به جای assignAll برای RxList
//     } catch (error) {
//       print('Error fetching orders: $error');
//     } finally {
//       //  isLoading = false; // تنظیم وضعیت بارگذاری به false
//       update(); // به روز رسانی ویجت‌های وابسته
//     }
//   }
//
//   String currentFilter = '';
//
//
//   Future<List<ProductB>> _fetchOrders() async {
//     // String filterQuery = 'type = "18zn54v3u6vfaqd"';
//
//     String filterQuery = '';
//     // if (currentPrivate.isNotEmpty) {
//     //   filterQuery += 'type = "$currentPrivate"';
//     // }
//     // if (currentSearch.isNotEmpty) {
//     //   filterQuery +=
//     //       (filterQuery.isNotEmpty ? ' && ' : '') + 'title ~ "$currentSearch"';
//     // }
//     if (currentFilter.isNotEmpty) {
//       filterQuery += (filterQuery.isNotEmpty ? ' && ' : '') + currentFilter;
//     }
//
//     int page = 1;
//     List<ProductB> products = [];
//
//
//     try {
//       while (true) {
//         final resultList = await _pb.collection(collectionName).getList(
//           page: page,
//           perPage: 50,
//         //  filter: filterQuery.isNotEmpty ? filterQuery : null,
//         //  sort: currentSort.isNotEmpty ? currentSort : null,
//           expand: 'listproducta,listproductb',
//         );
//
//         if (resultList.items.isEmpty) {
//           break;
//         }
//
//         for (var productJson in resultList.items) {
//           Map<String, dynamic> productData = productJson.toJson();
//
//           // پردازش اطلاعات تامین‌کننده به عنوان یک شیء منفرد به جای لیست
//           // در این قسمت مطمئن شوید که `supplier` در expand موجود است
//           Supplier? supplier;
//           if (productData['expand'] != null && productData['expand']['supplier'] != null) {
//             supplier = Supplier.fromJson(
//                 Map<String, dynamic>.from(productData['expand']['supplier']));
//           }
//
//
//           // ساختن یک محصول جدید با استفاده از داده‌های دریافت شده
//           ProductB product = ProductB.fromJson(
//             Map<String, dynamic>.from(productData),
//             supplier != null ? [supplier] : [],
//           );
//
//           products.add(product);
//           print(productJson.toJson());
//          // print(productJson['expand']);
//
//         }
//
//         page++;
//       }
//     } catch (error) {
//       print('Error fetching orders: $error');
//     }
//
//     await ChangeDate(products);
//     return products;
//   }
//
//
//   List<LocationSupplierModel> Datasort = [];
//
//
//   Future<List<LocationSupplierModel>> ChangeDate(List<ProductB> pro) async {
//     // نیازی به await برای pro نیست
//     List<ProductB> products = pro;
//     Map<String, List<ProductListSupplier>> supplierProductsMap = {};
//
//     for (var product in products) {
//       print('Product Title: ${product.title}');
//
//       if (product.supplier.isNotEmpty) {
//         for (var supplier in product.supplier) {
//           print('Supplier ID: ${supplier.id}');
//           print('Company Name: ${supplier.companyname}');
//
//           // ساخت ProductListSupplier
//           ProductListSupplier productListSupplier = ProductListSupplier(
//             IDProduct: product.id,
//             title: product.title,
//             number: product.number,
//             okbuy: product.okbuy,
//             hurry: product.hurry,
//             expectation: product.expectation,
//           );
//
//           // اضافه کردن محصول به لیست محصولات فروشنده در نقشه
//           if (!supplierProductsMap.containsKey(supplier.id)) {
//             supplierProductsMap[supplier.id] = [];
//           }
//           supplierProductsMap[supplier.id]!.add(productListSupplier);
//         }
//       } else {
//         print('No suppliers available for this product.');
//       }
//     }
//
//     List<LocationSupplierModel> newLocations = [];
//
//     // تبدیل نقشه به لیست LocationSupplierModel
//     for (var supplierId in supplierProductsMap.keys) {
//       var supplier = products
//           .expand((product) => product.supplier)
//           .firstWhere((sup) => sup.id == supplierId);
//
//       // جدا کردن مقدار طول و عرض جغرافیایی
//       List<String> locationParts = supplier.location.split(',');
//
//       if (locationParts.length == 2) {
//         double latitude = double.parse(locationParts[0]);
//         double longitude = double.parse(locationParts[1]);
//
//         // ساخت LocationSupplierModel جدید و اضافه کردن آن به لیست جدید
//         newLocations.add(
//           LocationSupplierModel(
//             idSupplier: supplier.id,
//             position: LatLng(latitude, longitude),
//             companyname: supplier.companyname,
//             phonenumber: supplier.phonenumber,
//             mobilenumber: supplier.mobilenumber,
//             address: supplier.address,
//             listPS: supplierProductsMap[supplierId]!,
//           ),
//         );
//       }
//     }
//
//     print('newLocations: ${newLocations.length}');
//
//     // مقداردهی لیست Datasort
//     Datasort = newLocations;
//     update(['products']);
//     return newLocations;
//   }
//
//
// }
//
//
//
//
// /////////////////////////////////////////////////
//
// class LocationUser {
//   final String id;
//   final String user;
//   final String latitude;
//   final String longitude;
//
//   LocationUser({
//     required this.id,
//     required this.user,
//     required this.latitude,
//     required this.longitude,
//   });
//
//   factory LocationUser.fromJson(Map<String, dynamic> json, List<LocationUser> productsA,
//       List<ProductB> productsB) {
//     return LocationUser(
//       id: json['id'].toString(),
//       user: json['user'].toString(),
//       latitude: json['latitude'].toString(),
//       longitude: json['longitude'].toString(),
//     );
//   }
// }
//
// class ProductB {
//   final String id;
//   final String title;
//   final String purchaseprice;
//   final List<Supplier> supplier;
//   final String days;
//   final String datecreated;
//   final String dataclearing;
//   final String number;
//   final String description;
//   final String datead;
//   final bool expectation;
//   final bool okbuy;
//   final bool hurry;
//   final bool official;
//
//   ProductB(
//       {required this.title,
//         required this.purchaseprice,
//         required this.id,
//         required this.supplier,
//         required this.days,
//         required this.datecreated,
//         required this.dataclearing,
//         required this.number,
//         required this.description,
//         required this.expectation,
//         required this.datead,
//         required this.okbuy,
//         required this.hurry,
//         required this.official});
//
//   factory ProductB.fromJson(
//       Map<String, dynamic> json, List<Supplier> suppliers) {
//     return ProductB(
//       title: json['title'].toString(),
//       purchaseprice: json['purchaseprice'].toString(),
//       id: json['id'].toString(),
//       supplier: suppliers,
//       days: json['days'].toString(),
//       datecreated: json['datecreated'].toString(),
//       dataclearing: json['dataclearing'].toString(),
//       number: json['number'].toString(),
//       description: json['description'].toString(),
//       datead: json['datead'].toString(),
//       expectation: json['expectation'],
//       okbuy: json['okbuy'],
//       hurry: json['hurry'],
//       official: json['official'],
//     );
//   }
// }
//
// class Supplier {
//   final String id;
//   final String companyname;
//   final String phonenumber;
//   final String mobilenumber;
//   final String address;
//   final String location;
//
//   Supplier({
//     required this.id,
//     required this.companyname,
//     required this.phonenumber,
//     required this.mobilenumber,
//     required this.address,
//     required this.location,
//   });
//
//   factory Supplier.fromJson(Map<String, dynamic> json) {
//     return Supplier(
//       id: json['id'] ?? '',
//       companyname: json['companyname'] ?? '',
//       phonenumber: json['phonenumber'] ?? '',
//       mobilenumber: json['mobilenumber'] ?? '',
//       address: json['address'] ?? '',
//       location: json['location'] ?? '',
//     );
//   }
// }
//
// /////////////////////////////////////////////////
//
// class LocationSupplierModel {
//   final List<ProductListSupplier> listPS;
//   final String idSupplier;
//   final String companyname;
//   final String phonenumber;
//   final String mobilenumber;
//   final String address;
//   final LatLng position;
//
//   LocationSupplierModel({
//     required this.idSupplier,
//     required this.position,
//     required this.companyname,
//     required this.phonenumber,
//     required this.mobilenumber,
//     required this.address,
//     required this.listPS,
//   });
// }
//
// class ProductListSupplier {
//   final String IDProduct;
//   final String title;
//   final String number;
//   final bool okbuy;
//   final bool hurry;
//   final RxBool expectation;
//
//   ProductListSupplier(
//       {required this.IDProduct,
//         required this.title,
//         required this.number,
//         required this.hurry,
//         required this.okbuy,
//         required bool expectation,  // regular bool passed in constructor
//       }) : expectation = RxBool(expectation); // Initialize RxBool
// }
//
//
//


import 'dart:async';
import 'package:flutter/foundation.dart';

import 'package:pocketbase/pocketbase.dart';
import 'package:http/http.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';

/////////////////////////////////////////////////

Client getClient() {
  return Client();
}

/////////////////////////////////////////////////

class OrderControllerProduct extends GetxController {

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



  List<ProductB> products = [];



  String currentFilter = ''; // فیلتر فعلی

  // متد برای تنظیم فیلتر و به‌روزرسانی داده‌ها
  Future<void> fetchAllProductsFilter({required String filter}) async {
    currentFilter = filter;
    await _fetchAndUpdate();
  }

  // متدی برای به‌روزرسانی داده‌ها بر اساس فیلترها
  Future<void> _fetchAndUpdate() async {
    products = await FetchProductsAndSupplier();
    update(); // به روز رسانی ویجت‌ها
  }

  // متدی برای دریافت و فیلتر کردن داده‌ها از API
  Future<List<ProductB>> FetchProductsAndSupplier() async {
    int page = 1;
    List<ProductB> products = [];

    // ساختن کوئری فیلتر با توجه به فیلترهای مختلف
    String filterQuery = 'okbuy = true'; // همه آیتم‌هایی که okbuy = true هستند

    // افزودن فیلتر دلخواه (currentFilter)
    if (currentFilter.isNotEmpty) {
      filterQuery += ' && $currentFilter';
    }
    try {
      while (true) {
        final resultList = await _pb.collection('listproductb').getList(
          page: page,
          perPage: 50,
          filter: filterQuery.isNotEmpty ? filterQuery : null,
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
  final String id;
  final String user;
  final String latitude;
  final String longitude;

  LocationUser({
    required this.id,
    required this.user,
    required this.latitude,
    required this.longitude,
  });

  factory LocationUser.fromJson(Map<String, dynamic> json, List<LocationUser> productsA,
      List<ProductB> productsB) {
    return LocationUser(
      id: json['id'].toString(),
      user: json['user'].toString(),
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