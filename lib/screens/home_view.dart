// ignore_for_file: avoid_unnecessary_containers, unused_field, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:financial_management_app/models/chart_data.dart';
import 'package:financial_management_app/data/database_helper.dart';
import 'package:financial_management_app/screens/add_income_view.dart';
import 'package:financial_management_app/screens/add_outcome_view.dart';
import 'package:financial_management_app/screens/detail_cash_flow_view.dart';
import 'package:financial_management_app/screens/settings_view.dart';
import 'package:flutter/material.dart';
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

  String totalIncome = '';
  String totalOutcome = '';

  List<ChartData> incomeData = [];
  List<ChartData> expenseData = [];

  @override
  void initState() {
    super.initState();
    fetchDataFromDatabase();
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
                child: FutureBuilder<String>(
                  future: loadTotalOutcome(),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      // Use the data when it's available
                      return Text('Total Outcome: Rp. ${snapshot.data}',
                          style: const TextStyle(
                              color: Colors.red,
                              fontSize: 15,
                              fontWeight: FontWeight.bold));
                    } else {
                      return const Text('Empty data');
                    }
                  },
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Center(
                child: FutureBuilder<String>(
                  future: loadTotalIncome(),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      // Use the data when it's available
                      return Text('Total Income: \Rp. ${snapshot.data}',
                          style: const TextStyle(
                              color: Colors.green,
                              fontSize: 15,
                              fontWeight: FontWeight.bold));
                    } else {
                      return const Text('Empty data');
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
                      color: Colors.green,
                      dataSource: incomeData,
                      xValueMapper: (ChartData data, _) => data.date,
                      yValueMapper: (ChartData data, _) => data.money,
                      name: 'Income',
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                    ),
                    LineSeries<ChartData, DateTime>(
                      dataSource: expenseData,
                      xValueMapper: (ChartData data, _) => data.date,
                      yValueMapper: (ChartData data, _) => data.money,
                      name: 'Expenses',
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
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
                      child: Container(
                        width: 120,
                        height: 120,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      AddIncomePage(uid: widget.user_id)),
                            );
                          },
                          child: Image.asset('images/profits.png'),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    // padding: const EdgeInsets.all(5),
                    child: Center(
                      child: Container(
                        width: 120,
                        height: 120,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        AddOutcomePage(uid: widget.user_id)));
                          },
                          child: Image.asset('images/outcome.png'),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    // padding: const EdgeInsets.all(5),
                    child: Center(
                      child: Container(
                        width: 120,
                        height: 120,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => DetailCashFlowPage(
                                        uid: widget.user_id)));
                          },
                          child: Image.asset('images/files.png'),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    // padding: const EdgeInsets.all(5),
                    child: Center(
                      child: Container(
                        width: 120,
                        height: 120,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        SettingPage(uid: widget.user_id)));
                          },
                          child: Image.asset('images/settings.png'),
                        ),
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

  // METHOD
  Future<String> loadTotalIncome() async {
    final sumIncome = await dbHelper.getSumIncomeForCurrentMonth();

    return totalIncome = sumIncome.toString();
    // setState(() {
    //   totalIncome = sumIncome;
    // });
  }

  Future<String> loadTotalOutcome() async {
    final sumOutcome = await dbHelper.getSumOutcomeForCurrentMonth();

    return totalOutcome = sumOutcome.toString();

    // setState(() {
    //   totalOutcome = sumOutcome;
    // });
  }

  Future<void> fetchDataFromDatabase() async {
    final db = await dbHelper.database;
    final now = DateTime.now();
    final currentMonth = DateFormat('yyyy-MM').format(now);
    final firstDayOfMonth = '$currentMonth-01';
    final lastDayOfMonth = '$currentMonth-31';

    final result = await db?.rawQuery(
      "SELECT * FROM keuangan WHERE tanggal >= ? AND tanggal <= ?",
      [firstDayOfMonth, lastDayOfMonth],
    );

    // final result = await db?.query('keuangan');

    // setState(() {
    //   incomeData = result!
    //       .where((row) => row['tipe'] == 'Pemasukan')
    //       .map((row) => ChartData(DateTime.parse(row['tanggal'] as String),
    //           row['nominal'] as double))
    //       .toList();

    //   expenseData = result
    //       .where((row) => row['tipe'] == 'Pengeluaran')
    //       .map((row) => ChartData(DateTime.parse(row['tanggal'] as String),
    //           row['nominal'] as double))
    //       .toList();
    // });

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
}
