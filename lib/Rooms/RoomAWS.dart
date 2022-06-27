import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../shared/ApplicationWidget.dart';
import '../shared/constants.dart';
import '../shared/loading.dart';
import '../shared/Custom_Widgets.dart';
import '../Home Room/Home_Screen.dart';

StreamController<bool> streamController = StreamController<bool>();
bool is_Loading = true;

class RoomAWS extends StatefulWidget {
  @override
    _RoomAWSState createState() => _RoomAWSState();
}

class _RoomAWSState extends State<RoomAWS> {

  void initState() {
    super.initState();
    setState(() {
      is_Loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return is_Loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text("AWS"),
              backgroundColor: cardColor,
              elevation: 10,
              toolbarHeight: 60,
              shadowColor: shadowColor,
            ),
            body: SafeArea(
              child: Container(
                padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                decoration: Background_decoration(),
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                        child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 12,
                      children: <Widget> [],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
