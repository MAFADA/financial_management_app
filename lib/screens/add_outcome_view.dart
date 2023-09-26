import 'package:financial_management_app/components/getTextFormField.dart';
import 'package:financial_management_app/data/database_helper.dart';
import 'package:financial_management_app/models/Keuangan.dart';
import 'package:financial_management_app/screens/home_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  margin: const EdgeInsets.only(top: 20.0),
                  child: TextFormField(
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(
                              2000), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101));

                      if (pickedDate != null) {
                        print(
                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        print(
                            formattedDate); //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement

                        setState(() {
                          tanggalController.text =
                              formattedDate; //set output date to TextField value.
                        });
                      } else {
                        print("Date is not selected");
                      }
                    },
                    controller: tanggalController,
                    validator: (val) =>
                        val!.isEmpty ? 'Please Enter Tanggal' : null,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        borderSide: BorderSide(color: Colors.deepPurple),
                      ),
                      prefixIcon: Icon(Icons.date_range),
                      hintText: 'Tanggal',
                      labelText: 'Tanggal',
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                  ),
                ),
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
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
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
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 5),
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
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 5),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => HomePage(
                                    user_id: widget.uid,
                                  )));
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
    double nominal = double.parse(pengeluaranController.text);
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
              context,
              MaterialPageRoute(
                  builder: (_) => HomePage(
                        user_id: widget.uid,
                      )));
        }).catchError((error) {
          _showMessageInScaffold('Error insert pengeluaran fail');
          print(error);
        });
      }
    }
  }
}
