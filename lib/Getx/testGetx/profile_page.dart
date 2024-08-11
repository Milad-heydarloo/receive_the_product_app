// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:receive_the_product/Getx/auth_controller.dart';
// import 'package:receive_the_product/Getx/routes.dart';
//
//
//
// class ProfilePages extends StatefulWidget {
//   const ProfilePages({Key? key}) : super(key: key);
//
//   @override
//   State<ProfilePages> createState() => _ProfilePagesState();
// }
//
// class _ProfilePagesState extends State<ProfilePages> {
//   final AuthController authController = Get.find<AuthController>();
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//    ini();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: () {
//               authController.logout();
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: FutureBuilder<bool>(
//           future: authController.checkVerificationStatus(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(child: CircularProgressIndicator());
//             }
//
//             if (snapshot.hasError || !snapshot.data!) {
//               return Center(child: Text('Error: You are not verified'));
//             }
//
//             final user = authController.getUser();
//
//             if (user == null) {
//               return Center(child: Text('Error: No user data available'));
//             }
//
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CircleAvatar(
//                   radius: 50,
//                   backgroundImage:
//                   user.avatar.isNotEmpty ? NetworkImage(user.avatar) : null,
//                   child:
//                   user.avatar.isEmpty ? Icon(Icons.person, size: 50) : null,
//                 ),
//                 SizedBox(height: 16),
//                 Text('Name: ${user.name ?? 'No name'}'),
//                 Text('Email: ${user.email ?? 'No email'}'),
//                 Text('Family: ${user.family ?? 'No family'}'),
//                 Text(
//                     'Availability: ${user.availability.join(', ') ?? 'No availability'}'),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   Future<void> ini() async {
//     bool user = await authController.checkVerificationStatus();
//     if (user != true) {
//       authController.clearUser();
//       Get.offAllNamed(Routes.login);
//     }
//   }
// }
//
