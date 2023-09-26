import 'package:financial_management_app/components/getTextFormField.dart';
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
  final _formKey = GlobalKey<FormState>();

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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
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
                      _signup();
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
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => LoginPage()),
                              (Route<dynamic> route) => false);
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
      ),
    );
  }

  _signup() async {
    String username = usernameController.text;
    String password = passwordController.text;
    if (_formKey.currentState!.validate()) {
      // AlertDialog();
      // ignore: unnecessary_null_comparison
      if (username.isEmpty) {
        _showMessageInScaffold('Please enter username');
      } else if (password.isEmpty) {
        _showMessageInScaffold('Please enter password');
      } else {
        _formKey.currentState!.save();

        // row to insert
        Map<String, dynamic> row = {
          DatabaseHelper.columnUserName: username,
          DatabaseHelper.columnPassword: password
        };

        User user = User.fromMap(row);
        await dbHelper.saveData(user).then((userData) {
          _showMessageInScaffold('Successfully Saved');

          Navigator.push(
              context, MaterialPageRoute(builder: (_) => LoginPage()));
        }).catchError((error) {
          _showMessageInScaffold('Data Save Fail');
        });
      }
    }
  }
}
