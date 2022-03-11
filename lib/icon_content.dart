import 'package:flutter/material.dart';
import 'constants.dart';
import 'living_room.dart';

class IconContent extends StatelessWidget {
  // late String icon;
  // late String label;
  // IconContent(icon, label) {
  //   this.icon = icon;
  //   this.label = label;
  // }
  final String icon;
  final String label;
  IconContent({required this.icon, required this.label}) {}
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          icon,
          height: 70,
          width: 70,
          color: Colors.white,
        ),
        SizedBox(height: 15),
        Text(
          label,
          style: kLabelStyle,
        )
      ],
    );
  }
}
