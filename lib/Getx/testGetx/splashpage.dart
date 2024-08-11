// import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:receive_the_product/Getx/auth_controller.dart';
// import 'package:receive_the_product/Getx/routes.dart';

//
// class SplashPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final AuthController authController = Get.find<AuthController>();
//
//     Future.delayed(Duration(seconds: 2), () async {
//       final token = GetStorage().read('token');
//       if (token != null) {
//         await authController.checkVerificationStatus(token);
//       } else {
//         Get.offAllNamed('/login');
//       }
//     });
//
//     return Scaffold(
//       body: Center(child: CircularProgressIndicator()),
//     );
//   }
// }

// class SplashPage extends StatefulWidget {
//   @override
//   _SplashPageState createState() => _SplashPageState();
// }
//
// class _SplashPageState extends State<SplashPage> {
//   final AuthController authController = Get.find<AuthController>();
//
//   @override
//   void initState() {
//     super.initState();
//     _navigateAfterSplash();
//   }
//
//   Future<void> _navigateAfterSplash() async {
//     await Future.delayed(Duration(milliseconds: 1500)); // Duration of splash screen
//
//     // Ensure no navigation operation is ongoing
//     if (!Get.isOverlaysOpen) {
//       bool user = await authController.checkVerificationStatus();
//       if (user != null) {
//         if (user) {
//           Get.offAllNamed(Routes.home);
//         } else {
//           authController.clearUser();
//           Get.offAllNamed(Routes.login);
//         }
//       } else {
//         Get.offAllNamed(Routes.login);
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: SizedBox(
//           height: 800,
//           width: 800,
//           child: FlutterSplashScreen.scale(
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [Colors.white, Colors.white],
//             ),
//             childWidget: Image.asset("assets/satter.png"),
//             duration: Duration(milliseconds: 1500),
//             animationDuration: Duration(milliseconds: 1000),
//           ),
//         ),
//       ),
//     );
//   }
// }
