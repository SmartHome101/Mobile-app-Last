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
  final double size_x;
  final double size_y;
  IconContent({required this.icon, required this.label, required this.size_x, required this
  .size_y}) {}
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          icon,
          height: size_x,
          width: size_y,

        ),
        Text(
          label,
          style: kLabelStyle,
        )
      ],
    );
  }
}
