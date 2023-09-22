import 'dart:async';
import 'package:financial_management_app/models/User.dart';
import 'package:financial_management_app/data/controller/login_ctr.dart';

class LoginRequest {
  LoginCtr connection = LoginCtr();
  Future<User?> getLogin(String username, String password) {
    var result = connection.getLogin(username, password);
    return result;
  }
}
