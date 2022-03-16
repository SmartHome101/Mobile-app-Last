import 'package:flutter/material.dart';
import 'package:smart_home_app/Login_Screen.dart';
import 'living_room.dart';
import 'reusabel_card.dart';
import 'icon_content.dart';
import 'constants.dart';
import 'package:smart_home_app/Login_Screen.dart';

int temp = 180;

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Hello ' + GetName())),
          actions: <Widget>[
            FlatButton(
              textColor: Colors.white,
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                      return LoginScreen();
                    }));
              },
              child: Text("Log out"),
              shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
            ),
          ],
          backgroundColor: Color(0xFF1D1E33),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Row(children: [
                Expanded(
                  child: ReusableCard(
                    colour: kDisabledinCardColor,
                    cardChild: IconContent(
                        icon: 'icons/bathroom.png', label: 'Bath Room'),
                    onPress: () {},
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    colour: kDisabledinCardColor,
                    cardChild: IconContent(
                        icon: 'icons/bedroom.png', label: "Bed Room"),
                    onPress: () {},
                  ),
                ),
              ]),
            ),
            Expanded(
              child: Row(children: [
                Expanded(
                  child: ReusableCard(
                    colour: kInactiveCardColor,
                    cardChild: IconContent(
                        icon: 'icons/living_room.png', label: "Living Room"),
                    onPress: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return LivingRoom();
                      }));
                    },
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    colour: kDisabledinCardColor,
                    cardChild: IconContent(
                        icon: 'icons/kitchen.png', label: "Kitchen"),
                    onPress: () {},
                  ),
                ),
              ]),
            ),
            Expanded(
              child: Row(children: [
                Expanded(
                  child: ReusableCard(
                    colour: kDisabledinCardColor,
                    cardChild:
                        IconContent(icon: 'icons/studio.png', label: "Studio"),
                    onPress: () {},
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    colour: kDisabledinCardColor,
                    cardChild: IconContent(
                        icon: 'icons/washing_room.png', label: "Washing Room"),
                    onPress: () {},
                  ),
                ),
              ]),
            ),
          ],
        ));
  }
}

String GetName()
{
  return "Alfy";
}
