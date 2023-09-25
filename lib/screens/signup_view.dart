import 'package:financial_management_app/data/database_helper.dart';
import 'package:financial_management_app/models/User.dart';
import 'package:financial_management_app/screens/login_view.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final dbHelper = DatabaseHelper.instance;

  // contollers insert user
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _showMessageInScaffold(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
              const Text(
                'Register',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 30.0,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                margin: const EdgeInsets.only(top: 20.0),
                child: TextFormField(
                  controller: usernameController,
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
                  controller: passwordController,
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
                    String username = usernameController.text;
                    String password = passwordController.text;

                    _signup(username, password);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple),
                  child: const Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Have an account?'),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => LoginPage()));
                      },
                      child: const Text(
                        'Login',
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

  void _signup(username, password) async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnUserName: username,
      DatabaseHelper.columnPassword: password
    };
    User user = User.fromMap(row);
    final id = await dbHelper.insert(user);
    _showMessageInScaffold('inserted row id: $id');
  }

  void _login(username, password) async{
    
  }
}
