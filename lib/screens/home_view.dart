// ignore_for_file: avoid_unnecessary_containers, unused_field, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:math';

import 'package:financial_management_app/models/chart_data.dart';
import 'package:financial_management_app/data/database_helper.dart';
import 'package:financial_management_app/screens/add_income_view.dart';
import 'package:financial_management_app/screens/add_outcome_view.dart';
import 'package:financial_management_app/screens/detail_cash_flow_view.dart';
import 'package:financial_management_app/screens/settings_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.user_id});
  final int? user_id;

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dbHelper = DatabaseHelper.instance;

  String? _totalPemasukan;
  String? _totalPengeluaran;

  Future<String> _calcTotalIncome() async {
    var total = (await dbHelper.calculateTotalIncome())[0]['total_pemasukan'];
    return _totalPemasukan = total.toString();
    // setState(() => _totalPemasukan = total);
  }

  Future<String> _calcTotalOutcome() async {
    var total =
        (await dbHelper.calculateTotalOutcome())[0]['total_pengeluaran'];
    return _totalPengeluaran = total.toString();
    // setState(() => _totalPengeluaran = total);
  }

  List<ChartData> incomeData = [];
  List<ChartData> expenseData = [];

  @override
  void initState() {
    super.initState();
    fetchDataFromDatabase();
  }

  Future<void> fetchDataFromDatabase() async {
    final db = await dbHelper.database;
    final result = await db?.query('keuangan');

    setState(() {
      incomeData = result!
          .where((row) => row['tipe'] == 'Pemasukan')
          .map((row) => ChartData(DateTime.parse(row['tanggal'] as String),
              row['nominal'] as double))
          .toList();

      expenseData = result
          .where((row) => row['tipe'] == 'Pengeluaran')
          .map((row) => ChartData(DateTime.parse(row['tanggal'] as String),
              row['nominal'] as double))
          .toList();
    });
  }

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
            SizedBox(
              width: double.infinity,
              child: Center(
                child: FutureBuilder(
                  future: _calcTotalOutcome(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          Visibility(
                            visible: snapshot.hasData,
                            child: Text(
                              snapshot.data,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 24),
                            ),
                          )
                        ],
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      if (snapshot.hasError) {
                        return const Text('Pengeluaran: Rp. -');
                      } else if (snapshot.hasData) {
                        // ignore: prefer_interpolation_to_compose_strings
                        return Text('Pengeluaran: Rp. ' + snapshot.data,
                            style: const TextStyle(
                                color: Colors.red,
                                fontSize: 15,
                                fontWeight: FontWeight.bold));
                      } else {
                        return const Text('Empty data');
                      }
                    } else {
                      return Text('State: ${snapshot.connectionState}');
                    }
                  },
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Center(
                child: FutureBuilder(
                  future: _calcTotalIncome(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          Visibility(
                            visible: snapshot.hasData,
                            child: Text(
                              snapshot.data,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 24),
                            ),
                          )
                        ],
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Text('Pemasukan: Rp. -${snapshot.error}');
                      } else if (snapshot.hasData) {
                        // ignore: prefer_interpolation_to_compose_strings
                        return Text('Pemasukan: Rp. ' + snapshot.data,
                            style: const TextStyle(
                                color: Colors.green,
                                fontSize: 15,
                                fontWeight: FontWeight.bold));
                      } else {
                        return const Text('Empty data');
                      }
                    } else {
                      return Text('State: ${snapshot.connectionState}');
                    }
                  },
                ),
              ),
            ),
            // TODO Grafik Pengeluaran dan Pemasukan
            Center(
              child: SizedBox(
                width: 350,
                child: SfCartesianChart(
                  primaryXAxis: DateTimeAxis(
                    dateFormat: DateFormat.yMd(),
                  ),
                  primaryYAxis: NumericAxis(
                    title: AxisTitle(text: 'Money'),
                  ),
                  series: <ChartSeries>[
                    LineSeries<ChartData, DateTime>(
                      dataSource: incomeData,
                      xValueMapper: (ChartData data, _) => data.date,
                      yValueMapper: (ChartData data, _) => data.money,
                      name: 'Income',
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                    ),
                    LineSeries<ChartData, DateTime>(
                      dataSource: expenseData,
                      xValueMapper: (ChartData data, _) => data.date,
                      yValueMapper: (ChartData data, _) => data.money,
                      name: 'Expenses',
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                    ),
                  ],
                ),
              ),
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
                                  builder: (_) =>
                                      AddIncomePage(uid: widget.user_id)));
                        },
                        size: GFSize.LARGE,
                        icon: const Icon(Icons.money),
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
                                  builder: (_) =>
                                      AddOutcomePage(uid: widget.user_id)));
                        },
                        size: GFSize.LARGE,
                        icon: const Icon(Icons.money_off),
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
                                  builder: (_) =>
                                      DetailCashFlowPage(uid: widget.user_id)));
                        },
                        size: GFSize.LARGE,
                        icon: const Icon(Icons.manage_search_outlined),
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
                                  builder: (_) =>
                                      SettingPage(uid: widget.user_id)));
                        },
                        size: GFSize.LARGE,
                        icon: const Icon(CupertinoIcons.gear_alt),
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
