import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailCashFlowPage extends StatefulWidget {
  const DetailCashFlowPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DetailCashFlowState createState() => _DetailCashFlowState();
}

class _DetailCashFlowState extends State<DetailCashFlowPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(10.0),
            child: const Text(
              'Detail Cash Flow',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            elevation: 2.0,
            margin: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
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
                      child: const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 10,
                        child: Icon(
                          CupertinoIcons.plus,
                          size: 15,
                        ),
                      ),
                    ),
                    const Text(
                      'Rp. 2.000.000',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )
                  ],
                ),
                subtitle: Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dapat bayaran panitia sertifikasi',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          '25-09-2023',
                          style: TextStyle(color: Colors.white),
                        ),
                      ]),
                ),
                trailing: Container(
                  child: const Icon(
                    CupertinoIcons.arrow_left,
                    color: Colors.green,
                  ),
                ),
                onTap: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
