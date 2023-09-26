// ignore_for_file: unused_field

import 'package:financial_management_app/components/getTextFormField.dart';
import 'package:financial_management_app/data/database_helper.dart';
import 'package:financial_management_app/screens/home_view.dart';
import 'package:financial_management_app/screens/signup_view.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final dbHelper = DatabaseHelper.instance;

  // contollers insert user
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = new GlobalKey<FormState>();

  void _showMessageInScaffold(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // padding: const EdgeInsets.only(top: 100, left: 30, right: 30),
        scrollDirection: Axis.vertical,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100.0,
              ),
              Image.asset(
                'images/money-management.png',
                width: 400,
                height: 200,
                fit: BoxFit.contain,
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                'Duwit Ku',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20.0,
                ),
              ),
              getTextFormField(
                  ctr: usernameController,
                  hintName: 'Username',
                  icon: Icons.person),
              getTextFormField(
                ctr: passwordController,
                hintName: 'Password',
                icon: Icons.lock,
                isObscureText: true,
              ),
              Container(
                margin: const EdgeInsets.all(30.0),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _login();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple),
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Does not have an account?'),
                    TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => SignUpPage()),
                            (Route<dynamic> route) => false);
                      },
                      child: const Text(
                        'Signup',
                        style: TextStyle(color: Colors.deepPurple),
                      ),
                      // style: TextButton.styleFrom(backgroundColor: Colors.deepPurple),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _login() async {
    String uname = usernameController.text;
    String pass = passwordController.text;

    if (uname.isEmpty) {
      _showMessageInScaffold('Please enter username');
    } else if (pass.isEmpty) {
      _showMessageInScaffold('Please enter password');
    } else {
      await dbHelper
          .getUser(uname, pass)
          // ignore: non_constant_identifier_names
          .then((userData) {
        if (userData != null) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => HomePage(user_id: userData.id,)),
              (Route<dynamic> route) => false);
        } else {
          _showMessageInScaffold('User not Found');
        }
      }).catchError((error) {
        print(error);
        _showMessageInScaffold('Error Login Fail');
      });
    }
  }
}
