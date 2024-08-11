//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:receive_the_product/Getx/Drawer/DrawerController.dart';
// import 'package:receive_the_product/Getx/auth_controller.dart';
//
// class MyDrawer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final AuthController authController = Get.find<AuthController>();
//     final MyDrawerController drawerController =
//         Get.find<MyDrawerController>(); // Updated controller
//     final user = authController.getUser();
//
//     return Drawer(
//       child: Directionality(
//         textDirection: TextDirection.rtl,
//         child: Column(
//           children: <Widget>[
//             UserAccountsDrawerHeader(
//               accountName: Text('${user!.name} ${user.family}'),
//               accountEmail: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('${user.email}'),
//                   Text(
//                     'نوع کاربری: ${user.availability.isNotEmpty ? user.availability.first : "نامشخص"}',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Colors.white70,
//                     ),
//                   ),
//
//                 ],
//               ),
//               currentAccountPicture: null,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: Colors.blue,
//               ),
//               margin: EdgeInsets.all(10),
//               otherAccountsPicturesSize: Size.square(75),
//               arrowColor: Colors.white,
//               otherAccountsPictures: [
//                 CircleAvatar(
//                   backgroundImage: NetworkImage(
//                     "https://saater.liara.run/api/files/_pb_users_auth_/${user.id}/${user.avatar}",
//                   ),
//                 ),
//               ],
//             ),
//             Obx(() => Directionality(
//                 textDirection: TextDirection.rtl,
//                 child: ListTile(
//                   leading: Icon(Icons.map_outlined),
//                   title: Text("نقشه"),
//                   selected: drawerController.selectedIndex.value == 0,
//                   selectedTileColor: Colors.blue.withOpacity(0.3),
//                   onTap: () {
//                     drawerController.setSelectedIndex(0);
//                     Get.toNamed('/home');
//                   },
//                 ))),
//             Obx(() => Directionality(
//                 textDirection: TextDirection.rtl,
//                 child: ListTile(
//                   leading: Icon(Icons.production_quantity_limits_outlined),
//                   title: Text("محصولات"),
//                   selected: drawerController.selectedIndex.value == 1,
//                   selectedTileColor: Colors.blue.withOpacity(0.3),
//                   onTap: () {
//                     drawerController.setSelectedIndex(1);
//                     Get.toNamed('/op');
//                   },
//                 ))), Obx(() => Directionality(
//                 textDirection: TextDirection.rtl,
//                 child: ListTile(
//                   leading: Icon(Icons.logout),
//                   title: Text("خروج از حساب کاربری"),
//                   selected: drawerController.selectedIndex.value == 3,
//                   selectedTileColor: Colors.blue.withOpacity(0.3),
//                   onTap: () {
//                     drawerController.setSelectedIndex(3);
//                     authController.logout();
//                   },
//                 ))),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:receive_the_product/Getx/Drawer/DrawerController.dart';
import 'package:receive_the_product/Getx/auth_controller.dart';
import 'package:receive_the_product/Getx/user_model.dart';

class MyDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    final MyDrawerController drawerController = Get.find<MyDrawerController>();

    return FutureBuilder<User?>(
      future: authController.getUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        final user = snapshot.data;

        if (user == null) {
          return Center(child: Text('No user data available'));
        }

        return Drawer(

          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text('${user.name} ${user.family}'),
                  accountEmail: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${user.email}'),
                      Text(
                        'نوع کاربری: ${user.availability.isNotEmpty ? user.availability.first : "نامشخص"}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  currentAccountPicture: null,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
                  ),
                  margin: EdgeInsets.all(10),
                  otherAccountsPicturesSize: Size.square(75),
                  arrowColor: Colors.white,
                  otherAccountsPictures: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        "https://saater.liara.run/api/files/_pb_users_auth_/${user.id}/${user.avatar}",
                      ),
                    ),
                  ],
                ),
                Obx(() => Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListTile(
                      leading: Icon(Icons.map_outlined),
                      title: Text("نقشه"),
                      selected: drawerController.selectedIndex.value == 0,
                      selectedTileColor: Colors.blue.withOpacity(0.3),
                      onTap: () {
                        drawerController.setSelectedIndex(0);
                        Get.toNamed('/home');
                      },
                    ))),
                Obx(() => Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListTile(
                      leading: Icon(Icons.production_quantity_limits_outlined),
                      title: Text("محصولات"),
                      selected: drawerController.selectedIndex.value == 1,
                      selectedTileColor: Colors.blue.withOpacity(0.3),
                      onTap: () {
                        drawerController.setSelectedIndex(1);
                        Get.toNamed('/op');
                      },
                    ))),
                Obx(() => Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListTile(
                      leading: Icon(Icons.logout),
                      title: Text("خروج از حساب کاربری"),
                      selected: drawerController.selectedIndex.value == 3,
                      selectedTileColor: Colors.blue.withOpacity(0.3),
                      onTap: () {
                        drawerController.setSelectedIndex(3);
                        authController.logout();
                      },
                    ))),
              ],
            ),
          ),
        );
      },
    );
  }
}
