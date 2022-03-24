import 'package:flutter/material.dart';
import 'reusabel_card.dart';
import 'icon_content.dart';
import 'constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'loading.dart';

StreamController<bool> streamController = StreamController<bool>();
bool is_Loading = true;

bool lampStatus = false;
bool fanStatus = false;
bool doorStatus = true;
bool heaterStatus = false;
bool windowStatus = false;
int temp = 22;
late DatabaseReference dbref;
late Map dataBase;

class LivingRoom extends StatefulWidget {
  @override
  _LivingRoomState createState() => _LivingRoomState();
}

class _LivingRoomState extends State<LivingRoom> {

  get_Data_from_Firebase() {
    dbref = FirebaseDatabase.instance.ref("Smart Home/The First Floor/Room 1");
    Stream<DatabaseEvent> stream = dbref.onValue;

// Subscribe to the stream!
    stream.listen((DatabaseEvent event) {
      if (!mounted) return;
      setState(() {
        dataBase = event.snapshot.value as Map;
        lampStatus = dataBase['led'];
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

  Future<void> update() async {
    await dbref.update({'led': !lampStatus});
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
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ReusableCard(
                      colour: kInactiveCardColor,
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            textBaseline: TextBaseline.alphabetic,
                            children: <Widget>[
                              IconContent(
                                  icon: temp > 30
                          ? 'assets/images/temp_high.png'
                          : 'assets/images/temp_low.png',
                                  label: "",
                              size_x: 100, size_y: 100 ),
                              Text(
                                temp.toString() + " C",
                                style: kFontStyle,
                              ),
                            ],
                          ),
                        ],
                      ),
                      onPress: () {
                        setState(() {
                          lampStatus = false;
                        });
                      }),
                ),
                Expanded(
                  child: Row(children: [
                    Expanded(
                      child: ReusableCard(
                          colour: doorStatus
                              ? kInactiveCardColor
                              : kActiveCardColor,
                          cardChild: IconContent(
                              icon: doorStatus
                                  ? 'icons/padlock.png'
                                  : 'icons/unlock.png',
                              label: "" ,
                              size_x: 80,
                              size_y : 80),
                          onPress: () {
                            setState(() {
                              doorStatus = !doorStatus;
                            });
                          }),
                    ),
                    Expanded(
                      child: ReusableCard(
                          colour: heaterStatus
                              ? kActiveCardColor
                              : kInactiveCardColor,
                          cardChild: IconContent(
                              icon: heaterStatus
                                  ? 'icons/heater_On.png'
                                  : 'icons/heater.png', label: "",
                              size_x: 80,
                              size_y : 80),
                          onPress: () {
                            setState(() {
                              heaterStatus = !heaterStatus;
                            });
                          }),
                    ),
                  ]),
                ),
                Expanded(
                  child: Row(children: [
                    Expanded(
                      child: ReusableCard(
                          colour: lampStatus
                              ? kActiveCardColor
                              : kInactiveCardColor,
                          cardChild: IconContent(
                              icon: lampStatus
                              ? 'icons/lights_On.png'
                              : 'icons/lights.png', label: '' ,
                              size_x: 80,
                              size_y : 80),
                          onPress: () {
                            if (!mounted) return;
                            setState(() {
                              update();
                            });
                          }),
                    ),
                    Expanded(
                      child: ReusableCard(
                        colour:
                            fanStatus ? kActiveCardColor : kInactiveCardColor,
                        cardChild: IconContent(
                            icon: fanStatus ?
                            'icons/cooling-fan_On.png' :
                            'icons/cooling-fan.png', label: "" ,
                            size_x: 100,
                            size_y : 100),
                        onPress: () {
                          setState(() {
                            fanStatus = !fanStatus;
                          });
                        },
                      ),
                    ),
                  ]),
                ),
                Expanded(
                  child: Row(children: [
                    Expanded(
                      child: ReusableCard(
                          colour: windowStatus
                              ? kActiveCardColor
                              : kInactiveCardColor,
                          cardChild: IconContent(
                              icon:  windowStatus ?
                              'icons/windows_On.png' :
                              'icons/windows.png', label: "" ,
                              size_x: 90,
                              size_y : 90),
                          onPress: () {
                            setState(() {
                              windowStatus = !windowStatus;
                            });
                          }),
                    ),
                  ]),
                ),
              ],
            ));
  }
}
