import 'package:flutter/material.dart';
import 'living_room.dart';
import 'input_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'body.dart';
import 'splash_screen.dart';
import 'package:smart_home_app/Login_Screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          primaryColor: Color(0xFF0A0E21),
          scaffoldBackgroundColor: Color(0xFF0A0E21)),
      home: SplashScreen(),
    );
  }
}

