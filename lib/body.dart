import 'package:smart_home_app/Login_Screen.dart';

import 'size_config.dart';
import 'package:flutter/material.dart';
import 'Home_Screen.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: Color(0xFF464646),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Welcome',
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(color: Colors.white, fontSize: 50),
          ),
          Material(
            child: Image.asset('assets/images/splash_img.png'),
            color: Colors.transparent,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LoginScreen();
              }));
            },
            child: Text(
              'Get Started',
              style: Theme.of(context).textTheme.headline2,
            ),
            style: ElevatedButton.styleFrom(
              elevation: 15,
              padding: EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 25,
              ),
              shadowColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25), // <-- Radius
              ),
            ),
          )
        ],
      ),
    );
  }
}
