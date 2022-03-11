import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Loading ...")),
        backgroundColor: Color(0xFF1D1E33),
      ),
    );
  }
}
