import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:Home/Home%20Room/Home_Screen.dart';
import 'package:Home/Splash,%20Sign%20In,%20Sign%20Up/Login_Screen.dart';
import 'Splash, Sign In, Sign Up/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
          primaryColor: Color(0xFF0A0E21),
          scaffoldBackgroundColor: Color(0xFF0A0E21)),
      home:
      Get_App_State() == ApplicationState.FirstTime
          ? SplashScreen()
          : Get_App_State() == ApplicationState.Remembered ?
          HomePage(userName) : LoginScreen()

    );
  }
}



enum ApplicationState {FirstTime, NotRememeberd, Remembered}

ApplicationState Get_App_State()
{
  //Code to decide the state

  //First Time = First time the user opens the app.
  //Not Rememember = Not first time, but there is no user data saved.
  //Rememeberd = There's userdata saved.



  return ApplicationState.FirstTime;
}




