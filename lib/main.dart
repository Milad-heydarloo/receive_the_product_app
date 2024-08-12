

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';

import 'package:latlong2/latlong.dart';
import 'package:receive_the_product/Getx/Drawer/DrawerController.dart';

import 'package:receive_the_product/Getx/Drawer/MyDrawer.dart';
import 'package:receive_the_product/Getx/auth_controller.dart';
import 'package:receive_the_product/Getx/routes.dart';
import 'package:receive_the_product/Getx/order.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:background_location/background_location.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';



void main() async {
  // await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AuthController(), permanent: true); // Ensure AuthController is always in memory
  Get.put(MyDrawerController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: Routes.splash,
      getPages: Routes.getPages,
      title: 'دریافت کالا ساتر',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'vazir',
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
        hintColor: Colors.black,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          color: Colors.blue,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blue, // رنگ دکمه‌ها
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.blue, // رنگ دکمه‌های متنی
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.blue, // رنگ دکمه‌های مرزی
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.blue,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Colors.blueAccent,
            ),
          ),
        ),
        // textTheme: TextTheme(
        //   headline1: TextStyle(
        //       fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue),
        //   headline6: TextStyle(
        //       fontSize: 18,
        //       fontWeight: FontWeight.bold,
        //       color: Colors.blueAccent),
        //   bodyText2: TextStyle(fontSize: 14, color: Colors.black87),
        // ),
        cardTheme: CardTheme(
          color: Colors.white,
          shadowColor: Colors.blueAccent,
          margin: EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
}


class SplashPages extends StatefulWidget {
  @override
  _SplashPagesState createState() => _SplashPagesState();
}

class _SplashPagesState extends State<SplashPages> {
  final AuthController authController = Get.find<AuthController>();



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(
        child: SizedBox(
          height: 800,
          width: 800,
          child: FlutterSplashScreen.scale(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Colors.white],
            ),
            childWidget: Image.asset("assets/satter.png"),
            duration: Duration(milliseconds: 2000),
            animationDuration: Duration(milliseconds: 1000),

            onEnd: () async {
              await Future.delayed(Duration(seconds: 2));
            await   authController.checkAndLogin();



            },

          ),
        ),
      ),
    );

  }
}

class LocationPickerScreen extends StatefulWidget {
  @override
  _LocationPickerScreenState createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  ///////

  ////////

  Position? _currentPosition;
  late MapController _mapController;
  double _zoom = 18;

  final OrderController orderController = Get.put(OrderController());
  final AuthController authController = Get.find<AuthController>();
  List<LocationSupplierModel> locations = [];
  bool _isListOpen = false;

  bool _isBackgroundTrackingEnabled = true; // وضعیت مکان‌یابی پس‌زمینه


  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _getCurrentLocation();
    _startLocationUpdates();
    if (_isBackgroundTrackingEnabled) {
      _initializeBackgroundLocation();
    }
  }

  void _initializeBackgroundLocation() async {
    // درخواست مجوز دسترسی به موقعیت مکانی
    await BackgroundLocation.startLocationService();

    // تنظیمات مربوط به دقت و فیلتر فاصله
    BackgroundLocation.setAndroidNotification(
      title: "Location Tracking",
      message: "Your location is being tracked in the background",
      icon: "@mipmap/ic_launcher",
    );
    final user = await authController.getUser();
    print('bbbbbbbbbb');
    print(user!.id.toString());
    BackgroundLocation.getLocationUpdates((location) {

      setState(() {
        LocationUser updatedLocation = LocationUser(

          latitude: location.latitude.toString(),
          longitude: location.longitude.toString(),
        );
        orderController.updateLocation(updatedLocation,user!.id);
      });

      print("Updated location: ${location.latitude}, ${location.longitude}");
    });
  }
  void _toggleBackgroundTracking() async {
    setState(() {
      _isBackgroundTrackingEnabled = !_isBackgroundTrackingEnabled;
    });

    if (_isBackgroundTrackingEnabled) {
      _initializeBackgroundLocation();
    } else {
      BackgroundLocation.stopLocationService();
    }
  }
  @override
  void dispose() {
    BackgroundLocation
        .stopLocationService(); // توقف بروزرسانی موقعیت مکانی هنگام خروج از برنامه
    super.dispose();
  }

  void _getCurrentLocation() async {
    await orderController.FetchProductsAndSupplier();
    locations = await orderController.Datasort;
    print(locations.length);
    setState(() {
      locations;
    });

    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = position;
    });
    print("Current location: ${position.latitude}, ${position.longitude}");
  }

  void _zoomIn() {
    setState(() {
      _zoom = (_zoom + 1).clamp(9, 18);
      _mapController.move(_mapController.center, _zoom);
    });
  }

  void _zoomOut() {
    setState(() {
      _zoom = (_zoom - 1).clamp(9, 18);
      _mapController.move(_mapController.center, _zoom);
    });
  }

  void _showCurrentLocation() {
    if (_currentPosition != null) {
      _mapController.move(
          LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          _zoom);
    }
  }

  void _focusOnMarkers() {
    if (_currentPosition == null) return;

    final allLocations = [
      LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
      ...locations.map((locationModel) => locationModel.position),
    ];

    LatLngBounds bounds = LatLngBounds.fromPoints(allLocations);

    _mapController.fitBounds(
      bounds,
      options: FitBoundsOptions(
        padding: EdgeInsets.all(50.0),
      ),
    );
  }

  late String apikey =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImMzNjVkMDg2NjdmMzgxZDY1ZmI2NzU0ODcwNDJmZTQ1M2I1MzgxODEyMWY5YTE2OTIwNjFlNDY2NDA2MmNlYzE0NjZmNzIzZDEzMzk4NTk1In0.eyJhdWQiOiIyODIxMyIsImp0aSI6ImMzNjVkMDg2NjdmMzgxZDY1ZmI2NzU0ODcwNDJmZTQ1M2I1MzgxODEyMWY5YTE2OTIwNjFlNDY2NDA2MmNlYzE0NjZmNzIzZDEzMzk4NTk1IiwiaWF0IjoxNzIxOTQwODg3LCJuYmYiOjE3MjE5NDA4ODcsImV4cCI6MTcyNDUzMjg4Nywic3ViIjoiIiwic2NvcGVzIjpbImJhc2ljIl19.P-HVICCEemigM5vv_lYuxVogPRp3_Tpa1-6zJWONRJ9BfsWXKd4B6FPgnxmJg1wkSGOXc_GFFoeZuFrf9nRfJzwdofkbFbI9yrtWWMATW2PIY8zjd_2SoZ4O94HE-AfyPOO4Dq_V7TJV1xiGinIJdyFCCfMBAuxN-2p8etP5UF2R6r9gDqxXpeVXiHbDx2zB9nTpONG_rlCi26SJ4Y63rDhsAOppdW6v0bP8bF7wkcOJ_z2lwzaWpcOnvJ0uP0cnYc_y9MiINw_P0g79MWMV-ntFNaaj_LU5G_kvSb9y0uWbmFrPgLoEgRFkdkRK2OEAORd9b5ux_iJGnkYV39UHPQ';
  bool _isTrackingEnabled = false;

  void _toggleTracking() {
    setState(() {
      _isTrackingEnabled = !_isTrackingEnabled;
    });
  }

  void _startLocationUpdates() async {

    final user = await authController.getUser();
    print('bbbbbbbbbb');
    print(user!.id.toString());
    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.medium,
        distanceFilter: 1,
      ),
    ).listen((Position position) {
      setState(() {
        LocationUser location = LocationUser(

            latitude: position.latitude.toString(),
            longitude: position.longitude.toString());
        orderController.updateLocation(location,user!.id);
        _currentPosition = position;
        if (_isTrackingEnabled) {
          _mapController.move(
            LatLng(position.latitude, position.longitude),
            _zoom,
          );
        }
      });
      print("Updated location: ${position.latitude}, ${position.longitude}");
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isTrackingEnabled ? Icons.location_on : Icons.location_off,
              color: _isTrackingEnabled ? Colors.green : Colors.red,
            ),
            onPressed: _toggleTracking,
          ),
          IconButton(
            icon: Icon(Icons.map),
            onPressed: _focusOnMarkers,
          ),
          IconButton(
            icon: Icon(
              _isBackgroundTrackingEnabled ? Icons.online_prediction : Icons.online_prediction,
              color: _isBackgroundTrackingEnabled ? Colors.green : Colors.red,
            ),
            onPressed: _toggleBackgroundTracking,
          ),
          // IconButton(
          //   icon: Icon(Icons.supervised_user_circle),
          //   onPressed: ()   {
          //
          //
          //
          //       Get.toNamed(Routes.profile);
          //
          //
          //   },
          // ),
        ],
        title: const Text('دریافت کالا ساتر'),
      ),
      body: Stack(
        children: [
          GetBuilder<OrderController>(
            id: 'products',
            builder: (controller) {
              if (_currentPosition == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: LatLng(_currentPosition!.latitude,
                        _currentPosition!.longitude),
                    initialZoom: _zoom,
                    minZoom: 8,
                    maxZoom: 18,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://map.ir/shiveh/xyz/1.0.0/Shiveh:Shiveh@EPSG:3857@png/{z}/{x}/{y}.png?x-api-key=${apikey}",
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          width: 80.0,
                          height: 80.0,
                          point: LatLng(_currentPosition!.latitude,
                              _currentPosition!.longitude),
                          child: Icon(
                            Icons.my_location,
                            // A different location-related icon
                            size: 50.0,
                            color: Colors.blue,
                          ),
                          key: Key(_currentPosition.toString()),
                        ),
                        ...controller.Datasort.map((locationModel) {
                          bool hasHurryProduct = locationModel.listPS
                              .any((product) => product.hurry);
                          return Marker(
                            width: calculateTextWidth(
                                    locationModel.companyname +
                                        'نام مجموعه : ') +
                                70,
                            height: 150,
                            point: locationModel.position,
                            child: GestureDetector(
                              onTap: () {
                                _showLocationDialog(locationModel);
                              },
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: Column(
                                  children: [
                                    Center(
                                      child: SizedBox(
                                        width: 800, // Maximum width of the Card
                                        child: IntrinsicWidth(
                                          child: Card(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Icons.circle,
                                                    color: hasHurryProduct
                                                        ? Colors.blue
                                                        : Colors.grey,
                                                    size: 20,
                                                  ),
                                                  SizedBox(width: 4),
                                                  AutoSizeText(
                                                    'نام مجموعه : ' +
                                                        locationModel
                                                            .companyname,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Icon(
                                      Icons.location_pin,
                                      size: 50.0,
                                      color: Colors.red,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ],
                );
              }
            },
          ),

          Positioned(
            bottom: 50,
            right: 10,
            child:



            Column(
              children: [
                FloatingActionButton(
                  onPressed: _zoomIn,
                  child: const Icon(Icons.zoom_in),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  onPressed: _zoomOut,
                  child: const Icon(Icons.zoom_out),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  onPressed: _showCurrentLocation,
                  child: const Icon(Icons.my_location),
                ),
              ],
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            left: 10,
            child: Column(
              children: [
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      _isListOpen = !_isListOpen;
                    });
                  },
                  child: Icon(_isListOpen ? Icons.close : Icons.menu),
                ),
                const SizedBox(height: 10),
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: double.infinity,
                  height: _isListOpen ? null : 0.0,
                  // اگر باز باشد ارتفاع براساس محتوا
                  constraints: _isListOpen
                      ? BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height *
                              0.7, // حداکثر ارتفاع
                        )
                      : BoxConstraints(),
                  color: Colors.white.withOpacity(0.9),
                  child: _isListOpen
                      ? SingleChildScrollView(
                          child: Column(
                            children: [
                              ...orderController.Datasort.map((locationModel) {
                                bool hasHurryProduct = locationModel.listPS
                                    .any((product) => product.hurry);
                                return ExpansionTile(
                                  title: ListTile(
                                    leading: Icon(
                                      Icons.circle,
                                      color: hasHurryProduct
                                          ? Colors.blue
                                          : Colors.grey,
                                      size: 20,
                                    ),
                                    title: Text(
                                      locationModel.companyname,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(locationModel.address),
                                    onTap: () {
                                      _mapController.move(
                                          locationModel.position,
                                          15.0); // حرکت نقشه به موقعیت
                                    },
                                  ),
                                  children: locationModel.listPS.map((product) {
                                    return Card(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      child: ListTile(
                                        title: Text(
                                          "نام کالا: ${product.title}",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "تعداد کالا جهت دریافت: ${product.number}",
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            Row(
                                              children: [
                                                Icon(Icons.circle,
                                                    color: product.hurry
                                                        ? Colors.blue
                                                        : Colors.grey),
                                                SizedBox(width: 5),
                                                Text(
                                                  "عجله دار",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: product.hurry
                                                          ? Colors.blue
                                                          : Colors.grey),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(Icons.circle,
                                                    color: product.okbuy
                                                        ? Colors.green
                                                        : Colors.grey),
                                                SizedBox(width: 5),
                                                Text(
                                                  "رزرو شده جهت دریافت",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: product.okbuy
                                                          ? Colors.green
                                                          : Colors.grey),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                );
                              }).toList(),
                            ],
                          ),
                        )
                      : null,
                ),
              ],
            ),
          )
        ],
      ),
     drawer:  MyDrawer(

     ),


    );
  }

  void _showLocationDialog(LocationSupplierModel locationModel) {
    Get.dialog(
      Builder(
        builder: (context) => AlertDialog(
          title: Center(
            child: Text(
              locationModel.companyname,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          content: Directionality(
            textDirection: TextDirection.rtl,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  Text("آدرس: ${locationModel.address}",
                      style: TextStyle(fontSize: 16)),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.phone),
                            onPressed: () {
                              _makePhoneCall(locationModel.phonenumber);
                            },
                          ),
                          Text(locationModel.phonenumber,
                              style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      SizedBox(width: 20),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.phone_android),
                            onPressed: () {
                              _makePhoneCall(locationModel.mobilenumber);
                            },
                          ),
                          Text(locationModel.mobilenumber,
                              style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: locationModel.listPS.map((product) {
                      return Card(
                        child: Column(
                          children: [
                            Text("نام کالا: ${product.title}",
                                style: TextStyle(fontSize: 16)),
                            SizedBox(height: 5),
                            Text("تعداد کالا جهت دریافت: ${product.number}",
                                style: TextStyle(fontSize: 16)),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Icon(Icons.circle,
                                    color: product.hurry
                                        ? Colors.blue
                                        : Colors.grey),
                                SizedBox(width: 5),
                                Text("عجله دار",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: product.hurry
                                            ? Colors.blue
                                            : Colors.grey)),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Icon(Icons.circle,
                                    color: product.okbuy
                                        ? Colors.green
                                        : Colors.grey),
                                SizedBox(width: 5),
                                Text("رزرو شده جهت دریافت",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: product.okbuy
                                            ? Colors.green
                                            : Colors.grey)),
                              ],
                            ),
                            SizedBox(height: 10),
                            Obx(() => Row(
                                  children: [
                                    Text(
                                      "دریافت شد کالا ؟ :",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Switch(
                                      value: product.expectation.value,
                                      onChanged: (value) {
                                        product.expectation.value = value;
                                        orderController
                                            .updateProduct(product.IDProduct);

                                        bool allReceived = locationModel.listPS
                                            .every((p) => p.expectation.value);

                                        if (allReceived) {
                                          Navigator.of(context).pop();
                                        }
                                      },
                                    ),
                                  ],
                                )),
                            Divider(),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  double calculateTextWidth(String text) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
      ),
      maxLines: 1,
      textDirection: TextDirection.rtl,
    )..layout(minWidth: 0, maxWidth: double.infinity);

    return textPainter.size.width;
  }

  void _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunch(launchUri.toString())) {
      await launch(launchUri.toString());
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }
}
