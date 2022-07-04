import 'package:Home/Home%20Room/Home_Screen.dart';
import 'package:flutter/material.dart';

const background_Color = Colors.black12;
const kFontStyle = TextStyle(fontSize: 50, fontWeight: FontWeight.w900);
const kBottomContainerHeight = 80.0;
const kActiveCardColor = Colors.black38; //Color(0xFF1D1E33);
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
  fontWeight: FontWeight.normal,
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

const appMainColor = Colors.white12;
const appSecondaryColor = Colors.blueGrey;
const shadowColor = Colors.black54;
const foregroundColor = Colors.white;

var cardColor = cardColor_Dark;
var cardBorder_On_Color = cardColor_Dark_Border_On;
var cardBorder_Off_Color = cardColor_Dark_Border_Off;


//DarkColors
const cardColor_Dark = Color(0xFF1D1E33);
var cardColor_Dark_Border_On = Colors.deepPurple[200];
var cardColor_Dark_Border_Off = Colors.black;

//Light Colors
const cardColor_Light = Color.fromARGB(100, 87, 56, 102);
var cardColor_Light_Border_On = Colors.deepPurple[200];
var cardColor_Light_Border_Off = Colors.black12;



enum Colormode { Color1, Color2, Color3 }

void Change_Color(color) {

  if (color == "Black")
  {
    cardColor = cardColor_Dark;
    cardBorder_On_Color = cardColor_Dark_Border_On;
    cardBorder_Off_Color = cardColor_Dark_Border_Off;

    Save_Color(Colormode.Color1);
  }
  else if (color == "White")
  {
    cardColor = cardColor_Light;
    cardBorder_On_Color = cardColor_Light_Border_On;
    cardBorder_Off_Color = cardColor_Light_Border_Off;

    Save_Color(Colormode.Color2);
  }
}

////////Save to local Database
void Save_Color(Colormode colormode) {
  if (colormode == Colormode.Color1) {
    //save 1
  } else if (colormode == Colormode.Color2) {
    //save 2
  } else {
    //save 3
  }
}
