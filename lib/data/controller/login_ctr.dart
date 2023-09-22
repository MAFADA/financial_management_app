import 'package:financial_management_app/models/User.dart';
import 'dart:async';
import 'package:financial_management_app/data/database_helper.dart';

class LoginCtr {
  DatabaseHelper connection = DatabaseHelper();

  //insert data
  Future<int?> saveUser(User user) async {
    var dbClient = await connection.db;
    int? result = await dbClient?.insert("User", user.toMap());
    return result;
  }

  //delete data
  Future<int?> deleteUser(User user) async {
    var dbClient = await connection.db;
    int? result = await dbClient?.delete("User");
    return result;
  }

  Future<User?> getLogin(String user, String password) async {
    var dbClient = await connection.db;
    var result = await dbClient?.rawQuery(
        "SELECT * FROM user WHERE username = '$user' and password = '$password'");

    if (result!.isNotEmpty) {
      return User.fromMap(result.first);
    }
    return null;
  }

  Future<List<User>?> getAllUser() async {
    var dbClient = await connection.db;
    var result = await dbClient?.query("user");

    List<User>? list =
        result!.isNotEmpty ? result.map((c) => User.fromMap(c)).toList() : null;
    return list;
  }
}
