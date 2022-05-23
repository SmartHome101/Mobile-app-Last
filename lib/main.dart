import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:Home/Home%20Room/Home_Screen.dart';
import 'package:Home/Splash,%20Sign%20In,%20Sign%20Up/Login_Screen.dart';
import 'Splash, Sign In, Sign Up/splash_screen.dart';
import './Controllers/shared_preferences.dart';

String? userName, photoURL;
bool? newUser;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var token = Get_App_State();
    print(token);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
            primaryColor: Color(0xFF0A0E21),
            scaffoldBackgroundColor: Color(0xFF0A0E21)),
        home: token == ApplicationState.FirstTime
            ? SplashScreen()
            : token == ApplicationState.Remembered
                ? HomePage(userName, photoURL)
                : LoginScreen());
  }
}

enum ApplicationState { FirstTime, NotRememeberd, Remembered }

ApplicationState Get_App_State() {
  newUser = CacheHelper.getData(key: "newUser");
  userName = CacheHelper.getData(key: "userName");
  photoURL = CacheHelper.getData(key: "photoURL");
  if (userName != null) {
    return ApplicationState.Remembered;
  } else if (newUser == false) {
    return ApplicationState.NotRememeberd;
  } else {
    return ApplicationState.FirstTime;
  }
}
