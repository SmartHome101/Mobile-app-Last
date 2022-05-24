import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../shared/ApplicationWidget.dart';
import '../shared/constants.dart';
import '../shared/loading.dart';
import '../shared/Custom_Widgets.dart';

StreamController<bool> streamController = StreamController<bool>();
bool is_Loading = true;
late DatabaseReference dbref;
late Map dataBase;
late List devices;

class Room extends StatefulWidget {
  final room_Name;
  const Room(this.room_Name);
  @override
  _RoomState createState() => _RoomState();
}

class _RoomState extends State<Room> {
  get_Data_from_Firebase() {
    dbref = FirebaseDatabase.instance.ref("HOME01/" + widget.room_Name);
    Stream<DatabaseEvent> stream = dbref.onValue;

// Subscribe to the stream!
    stream.listen((DatabaseEvent event) {
      if (!mounted) return;
      setState(() {
        print(event.snapshot.value);
        dataBase = event.snapshot.value as Map;
        devices = dataBase.entries
            .map((entry) => {entry.key: (entry.value == 0 ? false : true)})
            .toList();
        is_Loading = false;
        streamController.add(is_Loading);
      });
    });
  }

  void mySetState(bool state) {
    if (!mounted) return;
    setState(() {
      is_Loading = state;
    });
  }

  void initState() {
    super.initState();
    if (!streamController.hasListener) {
      streamController.stream.listen((state) {
        mySetState(state);
      });
    }
    get_Data_from_Firebase();
  }

  Future<void> update(name, value) async {
    await dbref.update({(name): (value == true ? 1 : 0)});
  }

  @override
  Widget build(BuildContext context) {
    return is_Loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text(widget.room_Name),
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
                      children: devices
                          .map((item) => ApplicationWidget(item, update))
                          .toList(),
                    ))
                  ],
                ),
              ),
            ),
          );
  }
}
