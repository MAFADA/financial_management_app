// ignore_for_file: prefer_const_declarations, unused_local_variable

import 'package:financial_management_app/models/Keuangan.dart';
import 'package:financial_management_app/models/User.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;

class DatabaseHelper {
  static final _databaseName = "  cashmanage_app.db";
  static final _databaseVersion = 1;

  static final table = 'cashmanage_app';

  static final columnId = 'id';
  static final columnUserName = 'username';
  static final columnPassword = 'password';

  static final tableKeuangan = 'keuangan';

  static final columnTanggal = 'tanggal';
  static final columnTipe = 'tipe';
  static final columnNominal = 'nominal';
  static final columnKeterangan = 'keterangan';

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
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
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

    await db.execute('''
          CREATE TABLE $tableKeuangan (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnTipe TEXT NOT NULL,
            $columnTanggal TEXT NOT NULL,
            $columnNominal INTEGER NOT NULL,
            $columnKeterangan TEXT NOT NULL
          )
          ''');
  }

  // HELPER METHODS

  // USER
  // Insert Data User
  Future<int?> saveData(User user) async {
    Database? db = await instance.database;
    return await db!.insert(table, user.toMap());
  }

  // Login
  Future<User?> getUser(String username, String password) async {
    Database? db = await instance.database;
    var res = await db?.rawQuery("SELECT * FROM $table WHERE "
        "$columnUserName = '$username' AND "
        "$columnPassword = '$password'");

    if (res!.isNotEmpty) {
      return User.fromMap(res.first);
    }

    return null;
  }

  // Update Data User
  Future<bool?> checkPassword(String username, String currentPassword) async {
    final db = await database;
    final result = await db?.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, currentPassword],
    );
    return result?.isNotEmpty;
  }

  Future<void> updatePassword(String username, String newPassword) async {
    final db = await database;
    await db?.update(
      'users',
      {'password': newPassword},
      where: 'username = ?',
      whereArgs: [username],
    );
  }

  // PEMASUKAN
  // Insert Data Pemasukan
  Future<int?> saveDataKeuangan(Keuangan keuangan) async {
    Database? db = await instance.database;
    return await db!.insert(tableKeuangan, keuangan.toMap());
  }

  Future calculateTotalIncome() async {
    Database? db = await instance.database;
    List<Map<String, Object?>> result;
    return result = await db!.rawQuery(
        "SELECT SUM($columnNominal) as total_pemasukan FROM keuangan WHERE tipe = 'Pemasukan'");
    // print(result);
  }

  Future calculateTotalOutcome() async {
    Database? db = await instance.database;
    List<Map<String, Object?>> result;
    return result = await db!.rawQuery(
        "SELECT SUM($columnNominal) as total_pengeluaran FROM keuangan WHERE tipe = 'Pengeluaran'");
    // print(result);
  }

  Future<List<Map<String, Object?>>?> fetchDataCashFlow() async {
    final db = await database;
    return await db?.query(tableKeuangan);
  }

  // PENGELUARAN
  // Insert Data Pengeluaran
  // Future<int?> saveDataPengeluaran(Pengeluaran pengeluaran) async {
  //   Database? db = await instance.database;
  //   return await db!.insert(tablePengeluaran, pengeluaran.toMap());
  // }
}
