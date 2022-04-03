import 'package:flutter/material.dart';

import '../shared/Custom_Widgets.dart';



class SlidingBar extends StatefulWidget {

  final ScrollController Scroll_controller;

  const SlidingBar({Key? key, required this.Scroll_controller}) : super(key: key);

  @override
  _SlidingBarState createState() => _SlidingBarState();
}

class _SlidingBarState extends State<SlidingBar> {

  @override
  Widget build(BuildContext context) => ListView(
    padding: EdgeInsets.all(5),
    children: [
      SizedBox(height: 8, width: 0,),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.arrow_upward,
            color: Colors.deepPurple,
          ),
          SizedBox(height: 0, width: 10,),
          Text("User Settings", style: TextStyle(fontSize: 20, color: Colors.white),),
        ],
      ),
      SizedBox(height: 18,),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              icon: Image.asset('icons/vector.png'),
              iconSize: 80,
              onPressed: () {
              }
          ),
          SizedBox(height: 0, width: 10,),
          IconButton(
              icon: Image.asset('icons/vector2.png'),
              iconSize: 80,
              onPressed: () {
              }
          ),
          SizedBox(height: 0, width: 10,),
          IconButton(
              icon: Image.asset('icons/vector3.png'),
              iconSize: 80,
              onPressed: () {
              }
          ),

        ],
      ),
      SizedBox(height: 20,),
      BuildUserName_Customized(),
      SizedBox(height: 20,),
      Build_Update(),
      SizedBox(height: 20,),
      Build_Logout(context),
      SizedBox(height: 25,),
    ],
  );
}

