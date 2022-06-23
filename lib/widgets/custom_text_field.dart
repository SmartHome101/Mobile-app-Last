import 'package:flutter/material.dart';
import 'package:Home/shared/constants.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({this.hintText, this.onChanged, this.isPassword, this.icon});

  Function(String)? onChanged;
  String? hintText;
  IconData? icon;
  bool? isPassword;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (data) {
        if (data!.isEmpty) {
          return "Field is Required";
        }
      },
      obscureText: isPassword!,
      onChanged: onChanged,
      decoration: InputDecoration(
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white),
          prefixIcon: Icon(
            icon,
            color: Colors.white,
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.blueGrey,
          )),
          border: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.black12,
          ))),
    );
  }
}

Widget BuildEmailTF(IconData icon, bool isPassword, Function(String) onChanged,
    String hintText) {
  return TextFormField(
    validator: (data) {
      if (data!.isEmpty) {
        return "Field is Required";
      }
    },
    obscureText: isPassword,
    onChanged: onChanged,
    decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
        prefixIcon: Icon(
          icon,
          color: Colors.white,
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.white,
        )),
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.white,
        ))),
  );
}
