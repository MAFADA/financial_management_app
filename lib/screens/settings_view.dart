// ignore_for_file: use_build_context_synchronously

import 'package:financial_management_app/components/getTextFormField.dart';
import 'package:financial_management_app/data/database_helper.dart';
import 'package:financial_management_app/screens/home_view.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key, required this.uid});
  final int? uid;
  @override
  // ignore: library_private_types_in_public_api
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final dbHelper = DatabaseHelper.instance;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController currentPass = TextEditingController();
  TextEditingController newPass = TextEditingController();

  // ignore: unused_element
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40.0,
              ),
              Container(
                margin: const EdgeInsets.only(left: 30),
                child: const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Pengaturan',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Container(
                margin: const EdgeInsets.only(left: 30, bottom: 5),
                child: const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Ganti Password',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
              getTextFormField(
                ctr: currentPass,
                hintName: 'Password Saat Ini',
                icon: Icons.lock,
                isObscureText: true,
              ),
              getTextFormField(
                ctr: newPass,
                hintName: 'Password Baru',
                icon: Icons.lock,
                isObscureText: true,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final uid = widget.uid;
                    final currentPassword = currentPass.text;
                    final newPassword = newPass.text;

                    final isPasswordCorrect =
                        await dbHelper.checkPassword(uid!, currentPassword);

                    if (isPasswordCorrect!) {
                      await dbHelper.updatePassword(uid, newPassword);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Password updated successfully!'),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Current password is incorrect!'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple),
                  child: const Text(
                    'Simpan',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 5),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HomePage(
                          user_id: widget.uid,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple),
                  child: const Text(
                    '<<Kembali',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 120.0,
        color: Colors.grey[200],
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 5),
              child: Image.asset(
                "images/M. Afada Nur Saiva Syahira.png",
                width: 150,
                height: 150,
                fit: BoxFit.contain,
              ),
            ),
            const Column(
              children: [
                Text('About This App'),
                SizedBox(
                  height: 10,
                ),
                Text('Aplikasi ini dibuat oleh:'),
                Text('Nama: M. Afada Nur Saiva Syahira'),
                Text('NIM: 2141764168'),
                Text('Tanggal: 25 September 2023'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
