import 'package:flutter/material.dart';


import '../shared/constants.dart';

class PanelWidget extends StatefulWidget {

  final ScrollController controller;
  const PanelWidget({Key? key, required this.controller}) : super(key: key);

  @override
  State<PanelWidget> createState() => _PanelWidgetState();
}


class _PanelWidgetState extends State<PanelWidget> {



  @override
  Widget build(BuildContext context) => ListView(

  );
}




