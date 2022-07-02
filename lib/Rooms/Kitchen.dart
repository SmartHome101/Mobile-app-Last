import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../shared/constants.dart';
import '../shared/loading.dart';
import '../shared/Custom_Widgets.dart';
import '../Home Room/Home_Screen.dart';

StreamController<bool> streamController = StreamController<bool>();
bool is_Loading = true;
late DatabaseReference dbref;


late Map dataBase;
late List devices;
late List fireHistory;
late DatabaseReference dbref_OnOff;


var fireState = "There's no fire !!";
var ultrasonic_value = 100;

class Kitchen extends StatefulWidget {
  @override
  _KitchenState createState() => _KitchenState();
}

class _KitchenState extends State<Kitchen> {
  get_Data_from_Firebase() {

    dbref = FirebaseDatabase.instance.ref(Home_Code + "/kitchen");
    dbref_OnOff =
        FirebaseDatabase.instance.ref(Home_Code + "/kitchen/history of fire");
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

        fireHistory = dataBase["history of fire"]
            .entries
            .map((entry) => entry.value).toList();

        fireState = dataBase["fire"];

        var count = fireHistory.where((c) => true).length;

        for(int i =0; i < count; i++)
          {
            print(fireHistory[i]);
          }


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

  @override
  Widget build(BuildContext context) {
    return is_Loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text("Kitchen"),
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
                          width: 3,
                        ),
                      ),
                      alignment: Alignment.center,
                      height: 50,
                      width: 350,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            ((ultrasonic_value > 1000) ? "Warning - your kid might be in the kitchen " : "Safe - Kitchen is empty"),
                            style: TextStyle(
                              fontSize: ((ultrasonic_value > 1000) ? 15 : 20),
                              color: Colors.deepPurple[200],
                            ),
                          ),
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
                    )),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: cardColor,
                        border: Border.all(
                          color: Colors.black,
                          width: 3,
                        ),
                      ),
                      alignment: Alignment.center,
                      height: 50,
                      width: 250,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            fireState  == "There's no fire !!" ? "No Fire" : "There's a Fire !!",
                            style: TextStyle(
                              fontSize: ((ultrasonic_value > 1000) ? 15 : 20),
                              color: fireState  == "There's no fire !!" ? Colors.deepPurple[200] : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                        child: GridView.count(
                          childAspectRatio: 7,
                          crossAxisCount: 1,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 12,
                          shrinkWrap: false,
                          children: fireHistory.map((item) => Fire_Data(item)).toList(),
                        )),

                  ],
                ),
              ),
            ),
          );
  }
}
