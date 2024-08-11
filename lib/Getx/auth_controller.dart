// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:pocketbase/pocketbase.dart';
// import 'package:receive_the_product/Getx/user_model.dart';
// import 'dart:convert';
//
// class AuthController extends GetxController {
//   final box = GetStorage();
//   final pb = PocketBase('https://saater.liara.run');
//
//   @override
//   void onInit() {
//     super.onInit();
//   }
//
//   void setUser(User user) {
//     final userJson = jsonEncode(user.toJson());
//     box.write('user', userJson);
//     update(['user']);
//   }
//
//   User? getUser() {
//     final userJson = box.read('user');
//     if (userJson != null) {
//       return User.fromJson(jsonDecode(userJson));
//     }
//     return null;
//   }
//
//   void clearUser() {
//     box.remove('user');
//     update(['user']);
//   }
//
//   void logout() {
//     clearUser();
//     Get.offAllNamed('/login');
//   }
//
//   Future<void> checkLoginStatus() async {
//     final userJson = box.read('user');
//     if (userJson != null) {
//       final user = User.fromJson(userJson);
//       if (user.verified) {
//         Get.offAllNamed('/home');
//       } else {
//         clearUser();
//         Get.offAllNamed('/login');
//       }
//     } else {
//       Get.offAllNamed('/login');
//     }
//   }
//
//
//   Future<void> login(String email, String password) async {
//     try {
//       final authData = await pb.collection('users').authWithPassword(email, password);
//       final userJson = authData.record!.toJson();
//       final user = User.fromJson(userJson);
//
//       // اضافه کردن پسورد به اطلاعات کاربر
//       user.password = password; // ذخیره کردن پسورد
//
//       if (user.verified) {
//         // ذخیره اطلاعات کاربر با پسورد
//         box.write('user', user.toJson());
//         setUser(user);
//         Get.offAllNamed('/home');
//       } else {
//         Get.snackbar('مشکل', 'شما مجاز به ورود نیستین',backgroundColor: Colors.red);
//       }
//     } catch (e) {
//       Get.snackbar('مشکل', 'ایمیل یا پسورد به درستی وارد نشده',backgroundColor: Colors.red);
//     }
//   }
//
//   // Future<User?> getUserFromServerOrStorage() async {
//   //   final userJson = box.read('user');
//   //   if (userJson != null) {
//   //     try {
//   //       final user = User.fromJson(jsonDecode(userJson));
//   //       if (user.verified) {
//   //         return user;
//   //       } else {
//   //         clearUser();
//   //         return null;
//   //       }
//   //     } catch (e) {
//   //       clearUser();
//   //       return null;
//   //     }
//   //   }
//   //   return null;
//   // }
//
//   // فرض بر این است که متد checkVerificationStatus که در فایل profile_page.dart استفاده می‌شود، به صورت زیر باشد
//   Future<bool> checkVerificationStatus() async {
//     bool check = false; // مقداردهی اولیه به false
//
//     final userJson = box.read('user');
//     if (userJson == null) {
//       Get.snackbar('Error', 'No user data found. Please login again.');
//       return check; // در صورتی که اطلاعات کاربر وجود نداشته باشد، false برگردانده می‌شود
//     }
//
//     final usersa = User.fromJson(jsonDecode(userJson));
//
//     try {
//       final authData = await pb.collection('users').authWithPassword(usersa.email, usersa.password);
//       final fetchedUserJson = authData.record!.toJson();
//       final user = User.fromJson(fetchedUserJson);
//
//       if (user.verified) {
//         // وضعیت تأیید درست است
//         check = true;
//         // اطلاعات کاربر را به روز کنید و به صفحه خانه هدایت کنید (اختیاری)
//         box.write('user', fetchedUserJson); // ذخیره اطلاعات کاربر به جای توکن
//         setUser(user);
//         Get.offAllNamed('/home');
//       } else {
//         Get.snackbar('Error', 'شما مجاز نیست');
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Invalid email or password');
//     }
//
//     return check; // در پایان متد، مقدار check برگردانده می‌شود
//   }
//
// }

//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pocketbase/pocketbase.dart';
// import 'package:receive_the_product/Getx/DataBase/sembast_database.dart';
// import 'package:sembast/sembast.dart';
// import 'package:receive_the_product/Getx/user_model.dart';
// import 'dart:convert';
//
//
// class AuthController extends GetxController {
//   final StoreRef<String, String> _store = StoreRef<String, String>.main();
//   final SembastDatabase _dbInstance = SembastDatabase();
//   final pb = PocketBase('https://saater.liara.run');
//   @override
//   void onInit() {
//     super.onInit();
//   }
//
//   Future<void> setUser(User user) async {
//     final db = await _dbInstance.database;
//     final userJson = jsonEncode(user.toJson());
//     await _store.record('user').put(db, userJson);
//     update(['user']);
//   }
//
//   // Future<User?> getUser() async {
//   //   final db = await _dbInstance.database;
//   //   final userJson = await _store.record('user').get(db);
//   //   if (userJson != null) {
//   //     return User.fromJson(jsonDecode(userJson));
//   //   }
//   //   return null;
//   // }
//   Future<User?> getUser() async {
//     final db = await _dbInstance.database;
//     final userJson = await _store.record('user').get(db);
//     if (userJson != null) {
//       return User.fromJson(jsonDecode(userJson));
//     }
//     return null;
//   }
//
//   Future<void> clearUser() async {
//     final db = await _dbInstance.database;
//     await _store.record('user').delete(db);
//     update(['user']);
//   }
//
//   void logout() async {
//     await clearUser();
//     Get.offAllNamed('/login');
//   }
//
//   Future<void> checkLoginStatus() async {
//     final user = await getUser();
//     if (user != null) {
//       if (user.verified) {
//         Get.offAllNamed('/home');
//       } else {
//         await clearUser();
//         Get.offAllNamed('/login');
//       }
//     } else {
//       Get.offAllNamed('/login');
//     }
//   }
//
//   Future<void> login(String email, String password) async {
//     try {
//       final authData = await pb.collection('users').authWithPassword(email, password);
//       final userJson = authData.record!.toJson();
//       final user = User.fromJson(userJson);
//
//       user.password = password;
//
//       if (user.verified) {
//         await setUser(user);
//         Get.offAllNamed('/home');
//       } else {
//         Get.snackbar('مشکل', 'شما مجاز به ورود نیستین', backgroundColor: Colors.red);
//       }
//     } catch (e) {
//       Get.snackbar('مشکل', 'ایمیل یا پسورد به درستی وارد نشده', backgroundColor: Colors.red);
//     }
//   }
//
//   Future<bool> checkVerificationStatus() async {
//     bool check = false;
//
//     final user = await getUser();
//     if (user == null) {
//       Get.snackbar('Error', 'No user data found. Please login again.');
//       return check;
//     }
//
//     try {
//       final authData = await pb.collection('users').authWithPassword(user.email, user.password);
//       final fetchedUserJson = authData.record!.toJson();
//       final fetchedUser = User.fromJson(fetchedUserJson);
//
//       if (fetchedUser.verified) {
//         check = true;
//         await setUser(fetchedUser);
//         Get.offAllNamed('/home');
//       } else {
//         Get.snackbar('Error', 'شما مجاز نیست');
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Invalid email or password');
//     }
//
//     return check;
//   }
// }

//
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pocketbase/pocketbase.dart';
// import 'package:receive_the_product/Getx/DataBase/sembast_database.dart';
// import 'package:receive_the_product/Getx/user_model.dart';
//
// class AuthController extends GetxController {
//   final pb = PocketBase('https://saater.liara.run');
//
//   @override
//   void onInit() {
//     super.onInit();
//   }
//
//
//   Future<User?> getUser() async {
//     try {
//       final path = await getLocalPath();
//       final file = File('$path/user.json');
//       if (await file.exists()) {
//         String content = await file.readAsString();
//         Map<String, dynamic> data = jsonDecode(content);
//         return User.fromJson(data);
//       } else {
//         print("File does not exist at path: $path/user.json");
//         return null;
//       }
//     } catch (e) {
//       print("Error in getUser: $e");
//       return null;
//     }
//   }
//
//   // تابع برای پاک‌سازی اطلاعات کاربر
//   Future<void> clearUser() async {
//     final path = await getLocalPath();
//     final file = File('$path/name_surname_verified.txt');
//     if (await file.exists()) {
//       await file.delete(); // حذف فایل
//     }
//     update(['user']);
//   }
//
//   // تابع برای خروج
//   void logout() async {
//     await clearUser();
//     Get.offAllNamed('/login');
//   }
//
//   // تابع برای ورود کاربر
//   Future<void> login(String email, String password) async {
//     try {
//       // احراز هویت کاربر
//       final authData = await pb.collection('users').authWithPassword(email, password);
//       final userJson = authData.record!.toJson();
//       final user = User.fromJson(userJson);
//
//       user.password = password; // ذخیره کردن پسورد در مدل کاربر
// print(user);
//       if (user.verified) {
//         // ذخیره اطلاعات کاربر در فایل
//         await saveNameSurnameAndVerified(email, password, true);
//         await saveUser(user);
//         // نمایش پیام ورود موفق
//         Get.snackbar('ورود موفق', 'شما با موفقیت وارد شدید.', backgroundColor: Colors.green);
//
//         // هدایت به صفحه خانه
//         Get.offAllNamed('/home');
//       } else {
//         // اگر کاربر تأیید نشده باشد، نمایش پیام دسترسی محدود
//         Get.snackbar('دسترسی محدود', 'حساب کاربری شما تأیید نشده است. لطفاً با پشتیبانی تماس بگیرید.', backgroundColor: Colors.red);
//       }
//     } catch (e) {
//       // در صورت خطا در ورود، نمایش پیام مناسب
//       Get.snackbar('ورود ناموفق', 'ایمیل یا رمز عبور نادرست است. لطفاً دوباره تلاش کنید.', backgroundColor: Colors.red);
//     }
//   }
//
//   Future<void> checkAndLogin() async {
//     try {
//       // مرحله 1: خواندن اطلاعات کاربر از فایل محلی
//       Map<String, dynamic> data = await readNameSurnameAndVerified();
//
//       if (data['email'].isNotEmpty && data['password'].isNotEmpty) {
//         // مرحله 2: اعتبارسنجی اطلاعات در سرور
//         final authData = await pb.collection('users').authWithPassword(data['email'], data['password']);
//         final userJson = authData.record!.toJson();
//         final user = User.fromJson(userJson);
//
//         user.password = data['password'];
//
//         // مرحله 3: بررسی وضعیت تأیید
//         if (user.verified) {
//           Get.offAllNamed('/home');
//         } else {
//           Get.snackbar('دسترسی محدود', 'حساب کاربری شما تأیید نشده است. لطفاً با پشتیبانی تماس بگیرید.', backgroundColor: Colors.red);
//           Get.offAllNamed('/login');
//         }
//       } else {
//         Get.offAllNamed('/login');
//       }
//     } catch (e) {
//       Get.snackbar('ورود ناموفق', 'ایمیل یا رمز عبور نادرست است. لطفاً دوباره تلاش کنید.', backgroundColor: Colors.red);
//       Get.offAllNamed('/login');
//     }
//   }
// }
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pocketbase/pocketbase.dart';
// import 'package:objectbox/objectbox.dart';
//
// import 'user_model.dart'; // مدل User
//
//
//
//
//
//
// class AuthController extends GetxController {
//   final pb = PocketBase('https://saater.liara.run');
//    late final Store _store;
//   late final Box<User> _userBox;
//
//   @override
//   void onInit() {
//     super.onInit();
//     _initDatabase();
//   }
//
//   Future<void> _initDatabase() async {
//    _store = await openStore(); // استفاده از متد openStore از فایل تولید شده
//    _userBox = _store.box<User>(); // ایجاد باکس برای مدل User
//   }
//
//   Future<User?> getUser() async {
//     try {
//       final users = _userBox.getAll(); // خواندن تمام کاربران
//       if (users.isNotEmpty) {
//         return users.first; // برگرداندن اولین کاربر
//       }
//       return null;
//     } catch (e) {
//       print("Error in getUser: $e");
//       return null;
//     }
//   }
//
//   Future<void> clearUser() async {
//     try {
//       _userBox.removeAll(); // حذف تمام رکوردهای کاربران
//       update(['user']);
//     } catch (e) {
//       print("Error in clearUser: $e");
//     }
//   }
//
//   Future<void> logout() async {
//     await clearUser(); // پاک‌سازی اطلاعات کاربر
//     Get.offAllNamed('/login'); // هدایت به صفحه ورود
//   }
//
//   Future<void> login(String email, String password) async {
//     try {
//       final authData = await pb.collection('users').authWithPassword(email, password);
//       final userJson = authData.record!.toJson();
//       final user = User.fromJson(userJson);
//
//       user.password = password; // ذخیره کردن پسورد در مدل کاربر
//       if (user.verified) {
//         _userBox.put(user); // ذخیره اطلاعات کاربر در ObjectBox
//         Get.snackbar('ورود موفق', 'شما با موفقیت وارد شدید.', backgroundColor: Colors.green);
//         Get.offAllNamed('/home'); // هدایت به صفحه خانه
//       } else {
//         Get.snackbar('دسترسی محدود', 'حساب کاربری شما تأیید نشده است. لطفاً با پشتیبانی تماس بگیرید.', backgroundColor: Colors.red);
//       }
//     } catch (e) {
//       Get.snackbar('ورود ناموفق', 'ایمیل یا رمز عبور نادرست است. لطفاً دوباره تلاش کنید.', backgroundColor: Colors.red);
//     }
//   }
//
//   Future<void> checkAndLogin() async {
//     try {
//       final user = await getUser(); // خواندن اطلاعات کاربر از ObjectBox
//       if (user != null && user.email.isNotEmpty && user.password.isNotEmpty) {
//         final authData = await pb.collection('users').authWithPassword(user.email, user.password);
//         final userJson = authData.record!.toJson();
//         final updatedUser = User.fromJson(userJson);
//
//         if (updatedUser.verified) {
//           Get.offAllNamed('/home'); // هدایت به صفحه خانه
//         } else {
//           Get.snackbar('دسترسی محدود', 'حساب کاربری شما تأیید نشده است. لطفاً با پشتیبانی تماس بگیرید.', backgroundColor: Colors.red);
//           Get.offAllNamed('/login'); // هدایت به صفحه ورود
//         }
//       } else {
//         Get.offAllNamed('/login'); // هدایت به صفحه ورود اگر اطلاعات موجود نیست
//       }
//     } catch (e) {
//       Get.snackbar('ورود ناموفق', 'ایمیل یا رمز عبور نادرست است. لطفاً دوباره تلاش کنید.', backgroundColor: Colors.red);
//       Get.offAllNamed('/login'); // هدایت به صفحه ورود در صورت بروز خطا
//     }
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pocketbase/pocketbase.dart';
// import 'package:scientisst_db/scientisst_db.dart';
//
// import 'package:receive_the_product/Getx/user_model.dart';
//
// class AuthController extends GetxController {
//   final pb = PocketBase('https://saater.liara.run');
//   late final Database _db;
//   late final CollectionReference<Map<String, dynamic>> _userCollection;
//
//   @override
//   void onInit() {
//     super.onInit();
//     _initializeDB();
//   }
//
//   Future<void> _initializeDB() async {
//     _db = await Database.open(path: 'path_to_your_database');
//     _userCollection = _db.collection('users');
//   }
//
//   Future<User?> getUser() async {
//     try {
//       final userDocs = await _userCollection.get();
//       if (userDocs.isNotEmpty) {
//         return User.fromJson(userDocs.first.data);
//       }
//       return null;
//     } catch (e) {
//       print("Error in getUser: $e");
//       return null;
//     }
//   }
//
//   Future<void> saveUser(User user) async {
//     try {
//       await _userCollection.clear(); // Clear old user data before saving
//       await _userCollection.add(user.toJson());
//     } catch (e) {
//       print("Error saving user: $e");
//     }
//   }
//
//   Future<void> clearUser() async {
//     try {
//       await _userCollection.clear();
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.remove('name_surname_verified');
//       update(['user']);
//     } catch (e) {
//       print("Error in clearUser: $e");
//     }
//   }
//
//   void logout() async {
//     await clearUser();
//     Get.offAllNamed('/login');
//   }
//
//   Future<void> login(String email, String password) async {
//     try {
//       final authData = await pb.collection('users').authWithPassword(email, password);
//       final userJson = authData.record!.toJson();
//       final user = User.fromJson(userJson);
//
//       user.password = password;
//       print(user);
//       if (user.verified) {
//         await saveNameSurnameAndVerified(email, password, true);
//         await saveUser(user);
//         Get.snackbar('ورود موفق', 'شما با موفقیت وارد شدید.', backgroundColor: Colors.green);
//         Get.offAllNamed('/home');
//       } else {
//         Get.snackbar('دسترسی محدود', 'حساب کاربری شما تأیید نشده است. لطفاً با پشتیبانی تماس بگیرید.', backgroundColor: Colors.red);
//       }
//     } catch (e) {
//       Get.snackbar('ورود ناموفق', 'ایمیل یا رمز عبور نادرست است. لطفاً دوباره تلاش کنید.', backgroundColor: Colors.red);
//     }
//   }
//
//   Future<void> checkAndLogin() async {
//     try {
//       Map<String, dynamic> data = await readNameSurnameAndVerified();
//
//       if (data['email'].isNotEmpty && data['password'].isNotEmpty) {
//         final authData = await pb.collection('users').authWithPassword(data['email'], data['password']);
//         final userJson = authData.record!.toJson();
//         final user = User.fromJson(userJson);
//
//         user.password = data['password'];
//
//         if (user.verified) {
//           Get.offAllNamed('/home');
//         } else {
//           Get.snackbar('دسترسی محدود', 'حساب کاربری شما تأیید نشده است. لطفاً با پشتیبانی تماس بگیرید.', backgroundColor: Colors.red);
//           Get.offAllNamed('/login');
//         }
//       } else {
//         Get.offAllNamed('/login');
//       }
//     } catch (e) {
//       Get.snackbar('ورود ناموفق', 'ایمیل یا رمز عبور نادرست است. لطفاً دوباره تلاش کنید.', backgroundColor: Colors.red);
//       Get.offAllNamed('/login');
//     }
//   }
// }


// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pocketbase/pocketbase.dart';
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';
// import 'user_model.dart';
//
// class AuthController extends GetxController {
//   final pb = PocketBase('https://saater.liara.run');
//   final cacheManager = DefaultCacheManager();
//
//   @override
//   void onInit() {
//     super.onInit();
//   }
//
//   Future<User?> getUser() async {
//     try {
//       final fileInfo = await cacheManager.getFileFromCache('user');
//       if (fileInfo != null && fileInfo.file.existsSync()) {
//         final fileContent = await fileInfo.file.readAsString();
//         return User.fromJson(jsonDecode(fileContent));
//       }
//       return null;
//     } catch (e) {
//       print("Error in getUser: $e");
//       return null;
//     }
//   }
//
//   Future<void> clearUser() async {
//     try {
//       await cacheManager.removeFile('user');
//       update(['user']);
//     } catch (e) {
//       print("Error in clearUser: $e");
//     }
//   }
//
//   void logout() async {
//     await clearUser();
//     Get.offAllNamed('/login');
//   }
//
//   Future<void> login(String email, String password) async {
//     try {
//       final authData = await pb.collection('users').authWithPassword(email, password);
//       final userJson = authData.record!.toJson();
//       final user = User.fromJson(userJson);
//
//       user.password = password; // ذخیره کردن پسورد در مدل کاربر
//       if (user.verified) {
//         // ذخیره اطلاعات کاربر در کش
//         await saveUser(user);
//
//         Get.snackbar('ورود موفق', 'شما با موفقیت وارد شدید.', backgroundColor: Colors.green);
//         Get.offAllNamed('/home');
//       } else {
//         Get.snackbar('دسترسی محدود', 'حساب کاربری شما تأیید نشده است. لطفاً با پشتیبانی تماس بگیرید.', backgroundColor: Colors.red);
//       }
//     } catch (e) {
//       Get.snackbar('ورود ناموفق', 'ایمیل یا رمز عبور نادرست است. لطفاً دوباره تلاش کنید.', backgroundColor: Colors.red);
//     }
//   }
//
//   Future<void> checkAndLogin() async {
//     try {
//       final user = await getUser();
//       if (user != null && user.email.isNotEmpty && user.password.isNotEmpty) {
//         // مرحله 2: اعتبارسنجی اطلاعات در سرور
//         final authData = await pb.collection('users').authWithPassword(user.email, user.password);
//         final serverUserJson = authData.record!.toJson();
//         final serverUser = User.fromJson(serverUserJson);
//
//         if (serverUser.verified) {
//           Get.offAllNamed('/home');
//         } else {
//           Get.snackbar('دسترسی محدود', 'حساب کاربری شما تأیید نشده است. لطفاً با پشتیبانی تماس بگیرید.', backgroundColor: Colors.red);
//           Get.offAllNamed('/login');
//         }
//       } else {
//         Get.offAllNamed('/login');
//       }
//     } catch (e) {
//       Get.snackbar('ورود ناموفق', 'مشکلی در اعتبارسنجی رخ داده است. لطفاً دوباره تلاش کنید.', backgroundColor: Colors.red);
//       Get.offAllNamed('/login');
//     }
//   }
//
//   Future<void> saveUser(User user) async {
//     try {
//       final userJson = jsonEncode(user.toJson());
//       final file = await cacheManager.putFile('user', utf8.encode(userJson));
//       print("User saved to cache: ${file.path}");
//     } catch (e) {
//       print("Error in saveUser: $e");
//     }
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:receive_the_product/Getx/TestDataBase/database_helper.dart';

import 'user_model.dart';

class AuthController extends GetxController {
  final pb = PocketBase('https://saater.liara.run');
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  void onInit() {
    super.onInit();
  }

  Future<User?> getUser() async {
    try {
      return await _databaseHelper.getUser();
    } catch (e) {
      print("Error in getUser: $e");
      return null;
    }
  }

  Future<void> clearUser() async {
    try {
      final user = await getUser();
      if (user != null) {
        await _databaseHelper.deleteUser(user.id);
      }
      update(['user']);
    } catch (e) {
      print("Error in clearUser: $e");
    }
  }

  void logout() async {
    await clearUser();
    Get.offAllNamed('/login');
  }

  Future<void> login(String email, String password) async {
    try {
      final authData = await pb.collection('users').authWithPassword(email, password);
      final userJson = authData.record!.toJson();
      final user = User.fromJson(userJson);
      user.password = password;
      // ذخیره اطلاعات کاربر در پایگاه داده
      await _databaseHelper.insertUser(user);

      Get.snackbar('ورود موفق', 'شما با موفقیت وارد شدید.', backgroundColor: Colors.green);
      Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar('ورود ناموفق', 'ایمیل یا رمز عبور نادرست است. لطفاً دوباره تلاش کنید.', backgroundColor: Colors.red);
    }
  }

  Future<void> checkAndLogin() async {
    try {
      final user = await getUser();
      if (user != null && user.email.isNotEmpty && user.password.isNotEmpty) {
        // مرحله 2: اعتبارسنجی اطلاعات در سرور
        final authData = await pb.collection('users').authWithPassword(user.email, user.password);
        final serverUserJson = authData.record!.toJson();
        final serverUser = User.fromJson(serverUserJson);

        Get.offAllNamed('/home');
      } else {
        Get.offAllNamed('/login');
      }
    } catch (e) {
      Get.snackbar('ورود ناموفق', 'مشکلی در اعتبارسنجی رخ داده است. لطفاً دوباره تلاش کنید.', backgroundColor: Colors.red);
      Get.offAllNamed('/login');
    }
  }
}
