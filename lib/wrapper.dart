import 'package:Home/Controllers/shared_preferences.dart';
import "./Splash, Sign In, Sign Up/Login_Screen.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "./Home Room/Home_Screen.dart";
import 'package:Home/Splash, Sign In, Sign Up/splash_screen.dart';

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var newUser = CacheHelper.getData(key: "newUser");

    final firebaseUser = context.watch<User?>();
    if (firebaseUser != null) {
      // ignore: prefer_const_constructors
      return HomePage();
    } else if (newUser == null) {
      return SplashScreen();
    }
    return LoginScreen();
  }
}
