import 'package:Home/Controllers/shared_preferences.dart';
import 'package:Home/pages/Login_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/Home_Screen.dart';
import 'pages/splash_screen.dart';

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var newUser = CacheHelper.getData(key: "newUser");

    final firebaseUser = context.watch<User?>();
    if (firebaseUser != null) {
      return HomePage();
    } else if (newUser == null) {
      return SplashScreen();
    }
    return LoginScreen();
  }
}
