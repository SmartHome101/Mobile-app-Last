import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../shared/Custom_Widgets.dart';
import 'constants.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Loading ...")),
        backgroundColor: cardColor,
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Lottie.asset('assets/images/98432-loading.json'),
          decoration: Background_decoration(),
          ),
        ),
    );
  }
}
