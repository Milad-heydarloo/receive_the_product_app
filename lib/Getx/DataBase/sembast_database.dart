// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart';
// import 'package:sembast/sembast.dart';
// import 'package:sembast/sembast_io.dart';
//
// class SembastDatabase {
//   static final SembastDatabase _singleton = SembastDatabase._internal();
//   static Database? _db;
//
//   factory SembastDatabase() {
//     return _singleton;
//   }
//
//   SembastDatabase._internal();
//
//   Future<Database> get database async {
//     if (_db == null) {
//       _db = await _openDatabase();
//     }
//     return _db!;
//   }
//
//   Future<Database> _openDatabase() async {
//     final dir = await getApplicationDocumentsDirectory();
//     await dir.create(recursive: true);
//     final dbPath = join(dir.path, 'app_database.db');
//     return databaseFactoryIo.openDatabase(dbPath);
//   }
// }
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:path_provider/path_provider.dart';
// import 'package:receive_the_product/Getx/user_model.dart'; // افزودن این خط برای استفاده از path_provider
//
// Future<String> getLocalPath() async {
//   if (kIsWeb) {
//     // برای وب، استفاده از localStorage یا IndexedDB
//     return '/'; // این مقدار نمادین است و در عمل باید از localStorage استفاده کنید
//   } else if (Platform.isAndroid || Platform.isIOS) {
//     // برای Android و iOS، استفاده از مسیر مناسب
//     final directory = await getApplicationDocumentsDirectory();
//     return directory.path;
//   } else if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
//     // برای دسکتاپ، استفاده از دایرکتوری جاری
//     return Directory.current.path;
//   } else {
//     // برای پلتفرم‌های دیگر، مسیر موقتی استفاده می‌شود
//     return '/tmp'; // مسیر موقتی برای تست
//   }
// }
//
// Future<void> saveNameSurnameAndVerified(String email, String password, bool verified) async {
//   try {
//     final path = await getLocalPath();
//     final file = File('$path/name_surname_verified.json');
//     Map<String, dynamic> content = {
//       'email': email,
//       'password': password,
//       'verified': verified
//     };
//     await file.writeAsString(jsonEncode(content));
//   } catch (e) {
//     print("Error in saveNameSurnameAndVerified: $e");
//   }
// }
// Future<void> saveUser(User user) async {
//   try {
//     final path = await getLocalPath();
//     final file = File('$path/user.json');
//     await file.writeAsString(jsonEncode(user.toJson()));
//   } catch (e) {
//     print("Error in saveUser: $e");
//   }
// }
//
// Future<Map<String, dynamic>> readNameSurnameAndVerified() async {
//   try {
//     final path = await getLocalPath();
//     final file = File('$path/name_surname_verified.json');
//     if (await file.exists()) {
//       String content = await file.readAsString();
//       Map<String, dynamic> data = jsonDecode(content);
//       return data;
//     } else {
//       print("File does not exist at path: $path/name_surname_verified.json");
//       return {'email': '', 'password': '', 'verified': false};
//     }
//   } catch (e) {
//     print("Error in readNameSurnameAndVerified: $e");
//     return {'email': '', 'password': '', 'verified': false};
//   }
// }

//
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:receive_the_product/Getx/user_model.dart'; // اضافه کردن مدل User
//
// Future<void> saveNameSurnameAndVerified(String email, String password, bool verified) async {
//   try {
//     final prefs = await SharedPreferences.getInstance();
//     final content = jsonEncode({
//       'email': email,
//       'password': password,
//       'verified': verified,
//     });
//     await prefs.setString('name_surname_verified', content);
//   } catch (e) {
//     print("Error in saveNameSurnameAndVerified: $e");
//   }
// }
//
// Future<void> saveUser(User user) async {
//   try {
//     final prefs = await SharedPreferences.getInstance();
//     final content = jsonEncode(user.toJson());
//     await prefs.setString('user', content);
//   } catch (e) {
//     print("Error in saveUser: $e");
//   }
// }
//
// Future<Map<String, dynamic>> readNameSurnameAndVerified() async {
//   try {
//     final prefs = await SharedPreferences.getInstance();
//     final content = prefs.getString('name_surname_verified');
//     if (content != null) {
//       return jsonDecode(content);
//     } else {
//       print("No data found for 'name_surname_verified'");
//       return {'email': '', 'password': '', 'verified': false};
//     }
//   } catch (e) {
//     print("Error in readNameSurnameAndVerified: $e");
//     return {'email': '', 'password': '', 'verified': false};
//   }
// }
//
// Future<User?> readUser() async {
//   try {
//     final prefs = await SharedPreferences.getInstance();
//     final content = prefs.getString('user');
//     if (content != null) {
//       final userJson = jsonDecode(content);
//       return User.fromJson(userJson);
//     } else {
//       print("No data found for 'user'");
//       return null;
//     }
//   } catch (e) {
//     print("Error in readUser: $e");
//     return null;
//   }
// }
