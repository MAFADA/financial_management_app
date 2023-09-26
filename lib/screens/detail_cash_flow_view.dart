import 'package:financial_management_app/data/database_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailCashFlowPage extends StatefulWidget {
  const DetailCashFlowPage({super.key, required this.uid});
  final int? uid;
  @override
  // ignore: library_private_types_in_public_api
  _DetailCashFlowState createState() => _DetailCashFlowState();
}

class _DetailCashFlowState extends State<DetailCashFlowPage> {
  final dbHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              child: const Text(
                'Detail Cash Flow',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 600,
              child: FutureBuilder(
                future: dbHelper.fetchDataCashFlow(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // Display a loading indicator while fetching data.
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('No data available.');
                  } else {
                    final data = snapshot.data!;
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final item = data[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          elevation: 2.0,
                          margin: const EdgeInsets.only(
                              bottom: 15, left: 15, right: 15),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.deepPurple,
                            ),
                            child: ListTile(
                              // leading: ,
                              title: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    child: item['tipe'] == 'Pemasukan'
                                        ? const CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 10,
                                            child: Icon(
                                              CupertinoIcons.plus,
                                              size: 15,
                                            ),
                                          )
                                        : const CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 10,
                                            child: Icon(
                                              CupertinoIcons.minus,
                                              size: 15,
                                            ),
                                          ),
                                  ),
                                  Text(
                                    'Rp. ${item['nominal']}',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                              subtitle: Container(
                                margin: const EdgeInsets.only(bottom: 5),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['keterangan'],
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      Text(
                                        item['tanggal'],
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ]),
                              ),
                              trailing: Container(
                                child: item['tipe'] == 'Pemasukan'
                                    ? const Icon(
                                        CupertinoIcons.arrow_left,
                                        color: Colors.green,
                                      )
                                    : const Icon(
                                        CupertinoIcons.arrow_right,
                                        color: Colors.red,
                                      ),
                              ),
                              // onTap: () {},
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
