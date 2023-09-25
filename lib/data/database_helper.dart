// ignore_for_file: prefer_const_declarations

import 'package:financial_management_app/models/User.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "  cashmanage_app.db";
  static final _databaseVersion = 1;

  static final table = 'cashmanage_app';

  static final columnId = 'id';
  static final columnUserName = 'username';
  static final columnPassword = 'password';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  // opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnUserName TEXT NOT NULL,
            $columnPassword TEXT NOT NULL
          )
          ''');
  }

  // HELPER METHODS

  // USER
  // Insert Data User
  Future<int?> insert(User user) async {
    Database? db = await instance.database;
    return await db!
        .insert(table, {'username': user.username, 'password': user.password});
  }

  // Update Data User
  Future<int?> update(User user) async {
    Database? db = await instance.database;
    int id = user.toMap()['id'];
    return await db!
        .update(table, user.toMap(), where: '$columnId = ?', whereArgs: [id]);
  }
}
