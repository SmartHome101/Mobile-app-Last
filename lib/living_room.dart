import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'loading.dart';
import '/Living Room/ApplicationWidget.dart';

StreamController<bool> streamController = StreamController<bool>();
bool is_Loading = true;
late DatabaseReference dbref;
late Map dataBase;
late List devices;

class LivingRoom extends StatefulWidget {
  @override
  _LivingRoomState createState() => _LivingRoomState();
}

class _LivingRoomState extends State<LivingRoom> {
  get_Data_from_Firebase() {
    dbref = FirebaseDatabase.instance.ref("Smart Home/Living Room");
    Stream<DatabaseEvent> stream = dbref.onValue;

// Subscribe to the stream!
    stream.listen((DatabaseEvent event) {
      if (!mounted) return;
      setState(() {
        dataBase = event.snapshot.value as Map;
        devices =
            dataBase.entries.map((entry) => {entry.key: entry.value}).toList();
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
    await dbref.update({name: value});
  }

  @override
  Widget build(BuildContext context) {
    return is_Loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text('Living Room'),
              backgroundColor: Color(0xFF1D1E33),
            ),
            body: SafeArea(
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                        child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
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
