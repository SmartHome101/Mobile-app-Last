import 'dart:async';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../shared/ApplicationWidget.dart';
import '../shared/constants.dart';
import '../shared/loading.dart';
import '../shared/Custom_Widgets.dart';
import '../Home Room/Home_Screen.dart';



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
    dbref = FirebaseDatabase.instance.ref("HOME" + Home_Code + "/living room/on-off");
    Stream<DatabaseEvent> stream = dbref.onValue;

// Subscribe to the stream!
    stream.listen((DatabaseEvent event) {
      if (!mounted) return;
      setState(() {
        print(event.snapshot.value);
        dataBase = event.snapshot.value as Map;
        devices =
            dataBase.entries.map((entry) => {entry.key: (entry.value == 0 ? false : true)}).toList();
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
    await dbref.update({(name):(value == true ? 1 : 0)});
  }

  @override
  Widget build(BuildContext context) {

    int Temperature = 25;

    double temp_ratio()
    {
      return Temperature/60.0;
    }

    return is_Loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text("living room"),
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
                    Text("Temperature", style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ShaderMask(
                            shaderCallback: (rect) {
                              return SweepGradient(
                                startAngle: 0.0,
                                endAngle: pi*2,
                                stops: [temp_ratio(),temp_ratio()],
                                colors: [Colors.deepPurpleAccent, Colors.white],
                              ).createShader(rect);
                            },
                            child: Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF1D1E33),
                            ),
                          ),
                          Text(Temperature.toString() + " C", style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Expanded(
                        child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 12,
                      children: devices.map((item) => ApplicationWidget(item, update)).toList(),)
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
