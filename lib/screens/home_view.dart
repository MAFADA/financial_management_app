import 'package:financial_management_app/screens/add_income_view.dart';
import 'package:financial_management_app/screens/add_outcome_view.dart';
import 'package:financial_management_app/screens/detail_cash_flow_view.dart';
import 'package:financial_management_app/screens/settings_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 25.0,
            ),
            const Text(
              'Rangkuman Bulan Ini',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20.0,
              ),
            ),
            const Text(
              'Pengeluaran: ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
                fontSize: 15.0,
              ),
            ),
            const Text(
              'Pemasukan: ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
                fontSize: 15.0,
              ),
            ),
            // TODO Grafik Pengeluaran dan Pemasukan
            Image.asset(
              'images/statistics.png',
              width: 400,
              height: 200,
              fit: BoxFit.contain,
            ),
            SizedBox(
              height: 400,
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(30),
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                crossAxisCount: 2,
                children: [
                  Container(
                    // padding: const EdgeInsets.all(5),
                    child: Center(
                      child: GFIconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => AddIncomePage()));
                        },
                        size: GFSize.LARGE,
                        icon: Icon(Icons.money),
                      ),
                    ),
                  ),
                  Container(
                    // padding: const EdgeInsets.all(5),
                    child: Center(
                      child: GFIconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => AddOutcomePage()));
                        },
                        size: GFSize.LARGE,
                        icon: Icon(Icons.money_off),
                      ),
                    ),
                  ),
                  Container(
                    // padding: const EdgeInsets.all(5),
                    child: Center(
                      child: GFIconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => DetailCashFlowPage()));
                        },
                        size: GFSize.LARGE,
                        icon: Icon(Icons.manage_search_outlined),
                      ),
                    ),
                  ),
                  Container(
                    // padding: const EdgeInsets.all(5),
                    child: Center(
                      child: GFIconButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => SettingPage()));
                        },
                        size: GFSize.LARGE,
                        icon: Icon(CupertinoIcons.gear_alt),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
