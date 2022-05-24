import 'package:flutter/material.dart';
import 'package:Home/shared/Custom_Widgets.dart';

class CustomeButton extends StatelessWidget {
  CustomeButton({required this.title, this.onTap});

  VoidCallback? onTap;
  String title;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          letterSpacing: 1.5,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'OpenSans',
        ),
      ),
      style: buttonStyle(Size(250, 50)),
      onPressed: onTap,
    );
  }
}
