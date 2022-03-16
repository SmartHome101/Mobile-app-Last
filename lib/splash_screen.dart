import 'package:flutter/material.dart';
import 'package:smart_home_app/Login_Screen.dart';
import 'size_config.dart';
import 'body.dart';
import 'package:smart_home_app/Sign_UpScreen.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = '/splash-screen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
