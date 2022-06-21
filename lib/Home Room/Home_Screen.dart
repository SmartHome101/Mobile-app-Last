import 'package:Home/Rooms/BedRoom.dart';
import 'package:Home/Rooms/Kitchen.dart';
import 'package:Home/Rooms/LivingRoom.dart';
import 'package:Home/Rooms/Reception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../Rooms/Bathroom.dart';
import '../shared/Custom_Widgets.dart';
import '../shared/constants.dart';
import '../Controllers/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final userName;
  final photoURL;
  const HomePage(this.userName, this.photoURL);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int temp = 40;
  String CurrentAvatar = 'icons/vector.png';

  TextEditingController UserName_Controller = TextEditingController();

  Color Highlighted_color = Color.fromARGB(40, 255, 255, 255);
  Color UnHighLighted_color = Colors.transparent;

  Color Avatar1_Color = Colors.transparent;
  Color Avatar2_Color = Colors.transparent;
  Color Avatar3_Color = Colors.transparent;

  Color Color1_BoarderColor = Colors.transparent;
  Color Color2_BoarderColor = Colors.transparent;
  Color Color3_BoarderColor = Colors.transparent;

  String Avatar1_Path = 'icons/vector.png';
  String Avatar2_Path = 'icons/vector2.png';
  String Avatar3_Path = 'icons/vector3.png';

  String Selected_Avatar = "";

  int Selected_Color = 1;

  initState() {
    setState(() {
      UserName_Controller.text = widget.userName;

      CurrentAvatar = widget.photoURL;

      if (CurrentAvatar == Avatar1_Path)
        Select_Avatar(1);
      else if (CurrentAvatar == Avatar2_Path)
        Select_Avatar(2);
      else if (CurrentAvatar == Avatar3_Path) Select_Avatar(3);

      // Selected_Color = await Get_Saved_Color() ;

      if (Selected_Color == 1)
        Change_Color("Red");
      else if (Selected_Color == 2)
        Change_Color("Black");
      else if (Selected_Color == 3) Change_Color("Blue");
    });
  }

  void Select_Avatar(int number) {
    if (number == 1) {
      Avatar1_Color = Highlighted_color;
      Avatar2_Color = UnHighLighted_color;
      Avatar3_Color = UnHighLighted_color;

      Selected_Avatar = Avatar1_Path;
    } else if (number == 2) {
      Avatar2_Color = Highlighted_color;
      Avatar1_Color = UnHighLighted_color;
      Avatar3_Color = UnHighLighted_color;

      Selected_Avatar = Avatar2_Path;
    } else if (number == 3) {
      Avatar3_Color = Highlighted_color;
      Avatar1_Color = UnHighLighted_color;
      Avatar2_Color = UnHighLighted_color;

      Selected_Avatar = Avatar3_Path;
    }
  }

  void Select_Color(int number) {
    if (number == 1) {
      Color1_BoarderColor = Highlighted_color;
      Color2_BoarderColor = UnHighLighted_color;
      Color3_BoarderColor = UnHighLighted_color;

      Change_Color("Red");
    } else if (number == 2) {
      Color2_BoarderColor = Highlighted_color;
      Color1_BoarderColor = UnHighLighted_color;
      Color3_BoarderColor = UnHighLighted_color;

      Change_Color("Black");
    } else if (number == 3) {
      Color3_BoarderColor = Highlighted_color;
      Color1_BoarderColor = UnHighLighted_color;
      Color2_BoarderColor = UnHighLighted_color;

      Change_Color("Blue");
    }

    Selected_Color = number;
  }

  Widget Build_Update() {
    return Container(
      alignment: Alignment.center,
      child: ElevatedButton(
        child: Text(
          'Update',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
        style: buttonStyle(Size(250, 50)),
        onPressed: () {
          update_UserData(
              Selected_Avatar, UserName_Controller.text, Selected_Color);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Map> _listItem = [
      {
        "img": "icons/reception.png",
        "name": "reception",
        "onPress": () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Reception();
          }));
        }
      },
      {
        "img": "icons/living_room.png",
        "name": "Living Room",
        "onPress": () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return LivingRoom();
          }));
        }
      },
      {
        "img": "icons/kitchen.png",
        "name": "Kitchen",
        "onPress": () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Kitchen();
          }));
        }
      },
      {
        "img": "icons/bathroom.png",
        "name": "Bathroom",
        "onPress": () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Bathroom();
          }));
        }
      },
      {
        "img": "icons/bedroom.png",
        "name": "Bed Room",
        "onPress": () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return BedRoom();
          }));
        }
      },
    ];

    return Scaffold(
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
            image: AssetImage(widget.photoURL),
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
      ),
      body: SlidingUpPanel(
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.fromLTRB(25, 15, 25, 5),
            decoration: Background_decoration(),
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
<<<<<<< Updated upstream
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
=======
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
                            image: AssetImage(temp > 40
                                ? 'assets/images/temp_high.png'
                                : 'assets/images/temp_low.png'),
                            width: 180,
                          ),
>>>>>>> Stashed changes
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
                  width: 30,
                ),
              ],
            ),
          ),
        ),
        color: cardColor,
        minHeight: 55,
        maxHeight: 430,
        border: Border.all(width: 2.0, color: Colors.white10),
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        panelBuilder: (controller) => ListView(
          padding: EdgeInsets.all(5),
          children: [
            SizedBox(
              height: 8,
              width: 0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "User Settings",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                SizedBox(
                  height: 0,
                  width: 10,
                ),
                Icon(
                  Icons.arrow_upward,
                  color: Colors.deepPurple,
                ),
              ],
            ),
            SizedBox(
              height: 18,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    icon: Image.asset(Avatar1_Path,
                        color: Avatar1_Color,
                        colorBlendMode: BlendMode.multiply),
                    iconSize: 80,
                    color: Colors.red,
                    onPressed: () {
                      setState(() {
                        Select_Avatar(1);
                      });
                    }),
                SizedBox(
                  height: 0,
                  width: 10,
                ),
                IconButton(
                    icon: Image.asset(Avatar2_Path,
                        color: Avatar2_Color,
                        colorBlendMode: BlendMode.multiply),
                    iconSize: 80,
                    onPressed: () {
                      setState(() {
                        Select_Avatar(2);
                      });
                    }),
                SizedBox(
                  height: 0,
                  width: 10,
                ),
                IconButton(
                    icon: Image.asset(Avatar3_Path,
                        color: Avatar3_Color,
                        colorBlendMode: BlendMode.multiply),
                    iconSize: 80,
                    onPressed: () {
                      setState(() {
                        Select_Avatar(3);
                      });
                    }),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            BuildUserName_Customized(UserName_Controller),
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                IconButton(
                  icon: Image.asset('icons/color1.png',
                      color: Color1_BoarderColor,
                      colorBlendMode: BlendMode.multiply),
                  onPressed: () {
                    setState(() {
                      Select_Color(1);
                    });
                  },
                ),
                IconButton(
                  icon: Image.asset('icons/color2.png',
                      color: Color2_BoarderColor,
                      colorBlendMode: BlendMode.multiply),
                  onPressed: () {
                    setState(() {
                      Select_Color(2);
                    });
                  },
                ),
                IconButton(
                  icon: Image.asset('icons/color3.png',
                      color: Color3_BoarderColor,
                      colorBlendMode: BlendMode.multiply),
                  onPressed: () {
                    setState(() {
                      Select_Color(3);
                    });
                  },
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
            SizedBox(
              height: 20,
            ),
            Build_Update(),
            SizedBox(
              height: 20,
            ),
            Build_Logout(context),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> update_UserData(
    String AvatarPath, String Name, int Selected_Color) async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    print(user);
    await user.updateDisplayName(Name);
    await user.updatePhotoURL(AvatarPath);
  }
}

Future<int> Get_Saved_Color() async {
  var color = await CacheHelper.getData(key: "color");
  print(color);
  return color;
}
