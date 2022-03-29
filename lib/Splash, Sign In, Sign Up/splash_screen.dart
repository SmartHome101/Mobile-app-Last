import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'Login_Screen.dart';
import '../shared/constants.dart';
import 'dart:ui';

class SplashScreen extends StatelessWidget {

  InitState()
  {
    On_FirstBuild();
  }

  DotsDecorator Custom_Dot_Decoration() => DotsDecorator(
    color: Color(0xFFBDBDBD),
    //activeColor: Colors.orange,
    size: Size(10, 10),
    activeSize: Size(22, 10),
    activeShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
  );
  PageDecoration Custom_Page_Decoration() => PageDecoration(
    titleTextStyle: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Colors.blueAccent
    ),
    bodyTextStyle: TextStyle(fontSize: 20, color: Colors.white, height: 1.5 ),
    imagePadding: EdgeInsets.all(24),
    pageColor: Colors.black26,
  );

  @override
  Widget build(BuildContext context) => SafeArea(
      child: IntroductionScreen(
        pages: [
        PageViewModel(
        title: "Getting Started",
        body: 'Control and monitor your house remotely',
        image: Image.asset("icons/Home_Icon.png", width: 500),
        decoration: Custom_Page_Decoration(),
      ),
          PageViewModel(
            title: 'Control Remotely',
            body: "You can control any device in your house at your fingertips, "
                "just open your phone, and use the app",
            image: Image.asset("icons/Using Phone.png", width: 500),
            decoration: Custom_Page_Decoration(),
          ),
          PageViewModel(
            title: 'Security comes first',
            body: "To make sure you'e secure, you create an account and use it to "
                "control your house",
            image: Image.asset("icons/Lock.png", width: 500),
            decoration: Custom_Page_Decoration(),
          ),

        ],
        dotsDecorator: Custom_Dot_Decoration(),
        done: Text('Get Started',),
        onDone: () {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return LoginScreen();
          }));
        },
        showSkipButton: true,
        skip: Text("skip"),
        next: Icon(Icons.arrow_forward),
        globalBackgroundColor: appMainColor,
      ),

  );



}


void On_FirstBuild()
{

}