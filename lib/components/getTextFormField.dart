// ignore: file_names
import 'package:flutter/material.dart';

// ignore: must_be_immutable, camel_case_types
class getTextFormField extends StatelessWidget {
  final TextEditingController ctr;
  final String hintName;
  final IconData icon;
  bool isObscureText;
  TextInputType inputType;

  getTextFormField(
      {required this.ctr,
      required this.hintName,
      required this.icon,
      this.inputType = TextInputType.text,
      this.isObscureText = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      margin: const EdgeInsets.only(top: 20.0),
      child: TextFormField(
        controller: ctr,
        obscureText: isObscureText,
        keyboardType: inputType,
        validator: (val) => val!.isEmpty ? 'Please Enter $hintName' : null,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(color: Colors.deepPurple),
          ),
          prefixIcon: Icon(icon),
          hintText: hintName,
          labelText: hintName,
          fillColor: Colors.grey[200],
          filled: true,
        ),
      ),
    );
  }
}
