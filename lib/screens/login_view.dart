// ignore_for_file: unused_field

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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                margin: const EdgeInsets.only(top: 20.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.deepPurple),
                    ),
                    prefixIcon: const Icon(Icons.person),
                    hintText: 'Username',
                    fillColor: Colors.grey[200],
                    filled: true,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                margin: const EdgeInsets.only(top: 10.0),
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.deepPurple),
                    ),
                    prefixIcon: const Icon(Icons.lock),
                    hintText: 'Password',
                    fillColor: Colors.grey[200],
                    filled: true,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(30.0),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                     Navigator.push(context,
                            MaterialPageRoute(builder: (_) => HomePage()));
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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => SignUpPage()));
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
}
