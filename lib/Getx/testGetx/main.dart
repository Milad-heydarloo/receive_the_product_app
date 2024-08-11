// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:receive_the_product/Getx/auth_controller.dart';
// import 'package:receive_the_product/Getx/routes.dart';
//
// void main() async {
//   await GetStorage.init();
//   Get.put(AuthController(), permanent: true); // Ensure AuthController is always in memory
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       initialRoute: Routes.splash,
//       getPages: Routes.getPages,
//     );
//   }
// }
//
// import 'package:flutter/material.dart';
//
// import 'package:get/get.dart';
// import 'package:receive_the_product/Getx/routes.dart';
//
//
// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             Get.toNamed(Routes.profile);
//           },
//           child: Text('Go to Profile'),
//         ),
//       ),
//     );
//   }
// }
//
//
