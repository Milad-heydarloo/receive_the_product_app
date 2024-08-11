import 'dart:convert';

import 'package:receive_the_product/Getx/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE user(
        id TEXT PRIMARY KEY,
        username TEXT,
        password TEXT,
        email TEXT,
        name TEXT,
        avatar TEXT,
        family TEXT,
        availability TEXT
      )
    ''');
  }

  Future<int> insertUser(User user) async {
    final db = await database;
    return await db.insert('user', {
      'id': user.id,
      'username': user.username,
      'password': user.password,
      'email': user.email,
      'name': user.name,
      'avatar': user.avatar,
      'family': user.family,
      'availability': jsonEncode(user.availability),
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<User?> getUser() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('user');
    if (maps.isNotEmpty) {
      final userData = maps.first;
      return User(
        id: userData['id'],
        username: userData['username'],
        password: userData['password'],
        verified: false, // چون در مدل ذخیره نمی‌شود
        email: userData['email'],
        name: userData['name'],
        avatar: userData['avatar'],
        family: userData['family'],
        availability: List<String>.from(jsonDecode(userData['availability'])),
      );
    }
    return null;
  }

  Future<int> updateUser(User user) async {
    final db = await database;
    return await db.update(
      'user',
      {
        'username': user.username,
        'password': user.password,
        'email': user.email,
        'name': user.name,
        'avatar': user.avatar,
        'family': user.family,
        'availability': jsonEncode(user.availability),
      },
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> deleteUser(String id) async {
    final db = await database;
    return await db.delete(
      'user',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

