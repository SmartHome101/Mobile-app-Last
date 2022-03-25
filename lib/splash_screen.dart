import 'package:flutter/material.dart';
import 'size_config.dart';
import 'body.dart';

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
