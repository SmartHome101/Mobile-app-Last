import 'package:Home/main.dart';
import 'package:flutter/material.dart';
import '../Controllers/shared_preferences.dart';
import '../Rooms/living_room.dart';
import '../Splash, Sign In, Sign Up/Login_Screen.dart';
import '../shared/constants.dart';
import '../Home Room/Home_Screen.dart';

class User_Settings extends StatefulWidget {

  final userName;
  const User_Settings(this.userName);

  @override
  _User_SettingsState createState() => _User_SettingsState();
}

class _User_SettingsState extends State<User_Settings> {


  @override
  Widget build(BuildContext context) {


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
        title: Row(
          children: <Widget>[
            FlatButton(
              child: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
              height: 25.0,
              onPressed: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return HomePage(userName);
                }));
              },
            ),
            Text(
              'User Settings',
              style: TextStyle(
                color: foregroundColor,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w300,
              ),

            ),
          ],
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
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LoginScreen();
              }));
            },
          )
        ],
      ),
      bottomNavigationBar: new SizedBox(
        height: 60,
        child: AppBar(
          elevation: 10,
          toolbarHeight: 60,
          backgroundColor: cardColor,
          bottom: PreferredSize(
              child: Container(
                color: Colors.white12,
                height: 4.0,
              ),
              preferredSize: Size.fromHeight(4.0)),
          automaticallyImplyLeading: false,
          shadowColor: shadowColor,
          title: Row(
            children: <Widget>[
              IconButton(
                onPressed: (){
                  setState(() {
                    Change_Color_Red();
                  });  }, icon: const Icon(Icons.circle), color: cardColor_red, ),
              IconButton(
                onPressed: (){
                  setState(() {
                    Change_Color_Black();
                  });
                }, icon: const Icon(Icons.circle), color: cardColor_blue,),
              IconButton(
                onPressed: (){
                  setState(() {
                    Change_Color_Blue();
                  });
                }, icon: const Icon(Icons.circle), color: cardColor_orange,),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
        ),
      ),
    );
  }
}
