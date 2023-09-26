import 'package:financial_management_app/components/getTextFormField.dart';
import 'package:financial_management_app/data/database_helper.dart';
import 'package:financial_management_app/models/Keuangan.dart';
import 'package:financial_management_app/screens/home_view.dart';
import 'package:flutter/material.dart';

class AddOutcomePage extends StatefulWidget {
  const AddOutcomePage({super.key, required this.uid});
  final int? uid;
  @override
  // ignore: library_private_types_in_public_api
  _AddOutcomePageState createState() => _AddOutcomePageState();
}

class _AddOutcomePageState extends State<AddOutcomePage> {
  final dbHelper = DatabaseHelper.instance;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController tanggalController = TextEditingController();
  TextEditingController pengeluaranController = TextEditingController();
  TextEditingController keteranganController = TextEditingController();

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
                  'Tambah Pengeluaran',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontSize: 30.0,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                getTextFormField(
                    ctr: tanggalController,
                    inputType: TextInputType.datetime,
                    hintName: 'Tanggal',
                    icon: Icons.date_range),
                getTextFormField(
                    ctr: pengeluaranController,
                    inputType: TextInputType.number,
                    hintName: 'Nominal',
                    icon: Icons.money),
                getTextFormField(
                    ctr: keteranganController,
                    hintName: 'Keterangan',
                    icon: Icons.description),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      tanggalController.text = '';
                      pengeluaranController.text = '';
                      keteranganController.text = '';
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple),
                    child: const Text(
                      'Reset',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _insertDataKeuangan,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple),
                    child: const Text(
                      'Simpan',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => HomePage(user_id: widget.uid,)));
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
      ),
    );
  }

  _insertDataKeuangan() async {
    String tanggal = tanggalController.text;
    String tipe = 'Pengeluaran';
    int nominal = int.parse(pengeluaranController.text);
    String keterangan = keteranganController.text;

    if (_formKey.currentState!.validate()) {
      // ignore: unnecessary_null_comparison
      if (tanggal.isEmpty) {
        _showMessageInScaffold('Please enter tanggal');
      } else if (nominal == 0) {
        _showMessageInScaffold('Please enter nominal Pengeluaran');
      } else {
        _formKey.currentState!.save();

        Map<String, dynamic> row = {
          DatabaseHelper.columnTanggal: tanggal,
          DatabaseHelper.columnTipe: tipe,
          DatabaseHelper.columnNominal: nominal,
          DatabaseHelper.columnKeterangan: keterangan,
        };

        Keuangan keuangan = Keuangan.fromMap(row);
        await dbHelper.saveDataKeuangan(keuangan).then((pemasukan) {
          _showMessageInScaffold('Successfully Saved');
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => HomePage(user_id: widget.uid,)));
        }).catchError((error) {
          _showMessageInScaffold('Error insert pengeluaran fail');
          print(error);
        });
      }
    }
  }
}
