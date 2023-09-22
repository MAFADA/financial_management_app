// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:financial_management_app/models/user.dart';
import 'package:financial_management_app/services/response/login_response.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginCallBack {
  late BuildContext? _ctx;
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late String? _username, _password;

  LoginResponse? _response;
  _LoginPageState() {
    _response = LoginResponse(this);
  }

  void _submit() {
    final form = formKey.currentState;
    if (form!.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        _response!.doLogin(_username!, _password!);
      });
    }
  }

  // void _showSnackBar(String text) {
  //   scaffoldKey.currentState?.showSnackBar(SnackBar(
  //     content: Text(text),
  //   ));
  // }

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.black87,
    backgroundColor: Colors.grey[300],
    minimumSize: const Size(88, 36),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    var loginBtn = ElevatedButton(
      onPressed: _submit,
      style: raisedButtonStyle,
      child: const Text("Login"),
    );

    var loginForm = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  onSaved: (val) => _username = val,
                  decoration: const InputDecoration(labelText: "Username"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  onSaved: (val) => _password = val,
                  decoration: const InputDecoration(labelText: "Password"),
                ),
              )
            ],
          ),
        ),
        loginBtn
      ],
    );
    return Scaffold(
      key: scaffoldKey,
      body: Column(
        children: [
          Image.asset(
            'images/money-management.png',
            width: 600,
            height: 240,
            fit: BoxFit.contain,
          ),
          loginForm,
        ],
      ),
    );
  }

  @override
  void onLoginError(String error) {
    //   // TODO: implement onLoginError
    //   _showSnackBar(error);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onLoginSuccess(User user) async {
    // ignore: unnecessary_null_comparison
    if (user != null) {
      Navigator.of(context).pushNamed("/home");
    } else {
      // // TODO: implement onLoginSuccess
      // _showSnackBar("Login Gagal, Silahkan Periksa Login Anda");
      setState(() {
        _isLoading = false;
      });
    }
  }
}
