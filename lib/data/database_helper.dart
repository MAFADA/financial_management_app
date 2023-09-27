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
            $columnNominal REAL NOT NULL,
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
  Future<bool?> checkPassword(int id, String currentPassword) async {
    final db = await database;
    final result = await db?.query(
      'cashmanage_app',
      where: 'id = ? AND password = ?',
      whereArgs: [id, currentPassword],
    );
    return result?.isNotEmpty;
  }

  Future<void> updatePassword(int id, String newPassword) async {
    final db = await database;
    await db?.update(
      'cashmanage_app',
      {'password': newPassword},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // PEMASUKAN
  // Insert Data Pemasukan
  Future<int?> saveDataKeuangan(Keuangan keuangan) async {
    Database? db = await instance.database;
    return await db!.insert(tableKeuangan, keuangan.toMap());
  }

  Future<List<Map<String, Object?>>?> fetchDataCashFlow() async {
    final db = await database;
    return await db?.query(tableKeuangan, orderBy: '$columnTanggal DESC');
  }

  Future<double> getSumIncomeForCurrentMonth() async {
    Database? db = await instance.database;

    final DateTime now = DateTime.now();
    final String currentMonth =
        '${now.year}-${now.month.toString().padLeft(2, '0')}';

    final result = await db?.rawQuery('''
    SELECT SUM(nominal) AS total_income
    FROM keuangan
    WHERE strftime('%Y-%m', tanggal) = '$currentMonth' AND tipe = 'Pemasukan'
  ''');

    final totalIncome = result?.first['total_income'];
    return totalIncome != null ? totalIncome as double : 0.0;
  }

  Future<double> getSumOutcomeForCurrentMonth() async {
    Database? db = await instance.database;

    final DateTime now = DateTime.now();
    final String currentMonth =
        '${now.year}-${now.month.toString().padLeft(2, '0')}';

    final result = await db?.rawQuery('''
    SELECT SUM(nominal) AS total_outcome
    FROM keuangan
    WHERE strftime('%Y-%m', tanggal) = '$currentMonth' AND tipe = 'Pengeluaran'
  ''');

    final totalIncome = result?.first['total_outcome'];
    return totalIncome != null ? totalIncome as double : 0.0;
  }
}
