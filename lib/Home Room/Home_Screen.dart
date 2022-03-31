import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../Controllers/shared_preferences.dart';
import '../Rooms/living_room.dart';
import '../shared/Custom_Widgets.dart';
import '../shared/constants.dart';
import '../Splash, Sign In, Sign Up/Login_Screen.dart';

class HomePage extends StatefulWidget {

  final userName;

  const HomePage(this.userName);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int temp = 40;

  @override
  Widget build(BuildContext context) {

    final List<Map> _listItem = [
      {"img": "icons/kitchen.png", "name": "Kitchen", "onPress": () {}},
      {"img": "icons/bathroom.png", "name": "Bathroom", "onPress": () {}},
      {
        "img": "icons/living_room.png",
        "name": "Living Room",
        "onPress": () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return LivingRoom();
          }));
        }
      },
      {"img": "icons/bedroom.png", "name": "Bed Room", "onPress": () {}},
      {
        "img": "icons/washing_room.png",
        "name": "Waching Room",
        "onPress": () {}
      },
      {"img": "icons/studio.png", "name": "Studio", "onPress": () {}},
    ];

    return  Scaffold(
      appBar: AppBar(
        elevation: 10,
        toolbarHeight: 60,
        backgroundColor: cardColor,
        shadowColor: shadowColor,
        bottom: PreferredSize(
            child: Container(
              color: Colors.white12,
              height: 4.0,
            ),
            preferredSize: Size.fromHeight(4.0)),
        leading: Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Image(
            image: AssetImage('icons/vector.png'),
          ),
        ),
        title: Text(
          'Hello ' + widget.userName,
          style: TextStyle(
            color: foregroundColor,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w300,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () async {
              await CacheHelper.RemoveData(key: 'userName');
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LoginScreen();
              }));
            },
          )
        ],
      ),
      body: SlidingUpPanel(
        body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(25, 15, 25, 5),
          decoration:  Background_decoration(),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: cardColor,
                  boxShadow: [
                    BoxShadow(
                      color: shadowColor,
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  textBaseline: TextBaseline.alphabetic,
                  children: <Widget>[
                    Transform.scale(
                      scale: 1.4,
                      child: Image(
                        image: AssetImage(temp > 30
                            ? 'assets/images/temp_high.png'
                            : 'assets/images/temp_low.png'),
                        width: 180,
                      ),
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          Text(
                            temp.toString(),
                            style: const TextStyle(
                                color: foregroundColor,
                                fontSize: 50,
                                fontWeight: FontWeight.normal),
                          ),
                          const Text(
                            'c',
                            style: TextStyle(
                              color: foregroundColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ]),
                  ],
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              Expanded(
                  child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 25,
                mainAxisSpacing: 15,
                scrollDirection: Axis.vertical,
                children: _listItem
                    .map((item) => GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: cardColor,
                              boxShadow: [
                                BoxShadow(
                                  color: shadowColor,
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  item['img'],
                                  height: 75,
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  item['name'],
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'OpenSans',
                                  ),
                                )
                              ],
                            ),
                          ),
                          onTap: item['onPress'],
                        ))
                    .toList(),
              )),
              const SizedBox(
                height: 145,
              ),
            ],
          ),
        ),
      ),
        color: cardColor,
        minHeight: 55,
        maxHeight: 300,
        border: Border.all(width: 1.0, color: Colors.deepPurple),
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        panelBuilder: (controller) => PanelWidget(
          controller: controller,
        ),
    ));
  }
}


class PanelWidget extends StatelessWidget {

  final ScrollController controller;
  const PanelWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView(
    padding: EdgeInsets.all(5),
    children: [
      SizedBox(height: 0,),
      Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.supervised_user_circle_outlined,
              color: Colors.deepPurple,
            ),
            onPressed: ()  {

            },
          ),
          Text(" User Settings - تحت الأنشاء", style: TextStyle(fontSize: 20, color: Colors.white),),
        ],
      )
    ],

  );
}



