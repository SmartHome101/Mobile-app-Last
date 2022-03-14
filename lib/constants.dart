import 'package:flutter/material.dart';

const kFontStyle = TextStyle(fontSize: 50, fontWeight: FontWeight.w900);
const kBottomContainerHeight = 80.0;
const kActiveCardColor = Color(0xFFEB1555); //Color(0xFF1D1E33);
const kInactiveCardColor = Color(0xFF1D1E33); //Color(0xFF111328);
const kDisabledinCardColor = Color(0xFF111328);
const kPrimaryColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);

final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.grey,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xFF6CA8F1),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);