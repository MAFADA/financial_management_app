import 'package:financial_management_app/services/request/login_request.dart';
import 'package:financial_management_app/models/user.dart';

abstract class LoginCallBack {
  void onLoginSuccess(User user);
  void onLoginError(String error);
}

class LoginResponse {
  final LoginCallBack _callBack;
  LoginRequest loginRequest = LoginRequest();
  LoginResponse(this._callBack);
  doLogin(String username, String password) {
    loginRequest
        .getLogin(username, password)
        .then((user) => _callBack.onLoginSuccess(user as User))
        .catchError((onError) => _callBack.onLoginError(onError.toString()));
  }
}
