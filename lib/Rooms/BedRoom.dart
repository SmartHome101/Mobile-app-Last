import 'dart:async';

import 'package:Home/Rooms/Kitchen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../Home Room/Home_Screen.dart';
import '../shared/constants.dart';
import '../shared/loading.dart';
import '../shared/Custom_Widgets.dart';

StreamController<bool> streamController = StreamController<bool>();
bool is_Loading = true;
late DatabaseReference dbref;
late DatabaseReference dbref_OnOff;
late DatabaseReference dbref_Light;
late Map dataBase;
late List devices;
var mode;
double lightValue = 1.0;

class BedRoom extends StatefulWidget {
  @override
  _BedRoomState createState() => _BedRoomState();
}

class _BedRoomState extends State<BedRoom> {
  get_Data_from_Firebase() {
    dbref = FirebaseDatabase.instance.ref(Home_Code + "/bedroom");
    dbref_OnOff = FirebaseDatabase.instance.ref(Home_Code + "/bedroom/on-off");
    dbref_Light = FirebaseDatabase.instance.ref(Home_Code + "/bedroom/light");

    Stream<DatabaseEvent> stream = dbref.onValue;

// Subscribe to the stream!
    stream.listen((DatabaseEvent event) {
      if (!mounted) return;
      setState(() {
        dataBase = event.snapshot.value as Map;

        devices = dataBase["on-off"]
            .entries
            .map((entry) => {entry.key: (entry.value == 0 ? false : true)})
            .toList();

        mode = dataBase["light"]["mode"];

        // mode = mode.toString().replaceAll("{mode: ", "").replaceAll("}", "");

        lightValue = ValueFromMode(mode);

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
    await dbref_OnOff.update({(name): (value == true ? 1 : 0)});
  }

  Future<void> updateLight(name, value) async {
    await dbref_Light.update({(name): (value)});
  }

  @override
  Widget build(BuildContext context) {
    return is_Loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              title: Text("Bed Room"),
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
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: cardColor,
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      alignment: Alignment.center,
                      height: 150,
                      width: 350,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.light,
                                color: Colors.white,
                              ),
                              // const SizedBox(
                              //   width: 10,
                              // ),
                              Text(
                                "Light",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            mode,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          Slider(
                            value: lightValue,
                            min: 0,
                            max: 100,
                            activeColor: lightValue > 5
                                ? Colors.deepPurple
                                : Colors.white,
                            onChanged: (value) {
                              setState(() {
                                lightValue = value;

                                var value2 = SliderSnapValue(value);
                                String mode = ModeFromValue(value2);
                                updateLight("mode", mode);
                              });
                            },
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                        child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 12,
                      children: devices
                          .map((item) => On_Off_Widget(item, update))
                          .toList(),
                    ))
                  ],
                ),
              ),
            ),
          );
  }
}

double SliderSnapValue(double value) {
  double _value = 0;

  if (value < 5) {
    _value = 0;
  } else if (value >= 5 && value <= 25) {
    _value = 25;
  } else if (value > 25 && value <= 50) {
    _value = 50;
  } else if (value > 50 && value <= 75) {
    _value = 75;
  } else if (value > 75) {
    _value = 100;
  }

  return _value;
}

String ModeFromValue(double value) {
  String mode = "off";

  if (value < 5) {
    mode = "off";
  } else if (value >= 5 && value <= 25) {
    mode = "low";
  } else if (value > 25 && value <= 50) {
    mode = "medium";
  } else if (value > 50 && value <= 75) {
    mode = "high";
  } else if (value > 75) {
    mode = "on";
  }

  return mode;
}

double ValueFromMode(String mode) {
  if (mode == "off")
    return 0;
  else if (mode == "low")
    return 25;
  else if (mode == "medium")
    return 50;
  else if (mode == "high")
    return 75;
  else
    return 100;
}
