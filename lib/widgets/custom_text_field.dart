import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({this.hintText, this.onChanged, this.isPassword, this.icon});

  Function(String)? onChanged;
  String? hintText;
  bool? isPassword;
  IconData? icon;
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
      style: TextStyle(color: Colors.white),
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
