import 'package:financial_management_app/screens/home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              // margin: const EdgeInsets.only(top: 20.0),
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
                  prefixIcon: const Icon(Icons.lock_open),
                  hintText: 'Password Saat Ini',
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              margin: const EdgeInsets.only(top: 10.0),
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
                  prefixIcon: const Icon(Icons.lock_outline),
                  hintText: 'Password Baru',
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
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
                      context, MaterialPageRoute(builder: (_) => HomePage()));
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
      bottomNavigationBar: Container(
        height: 120.0,
        color: Colors.grey[200],
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 5),
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
