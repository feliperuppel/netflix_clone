import 'package:flutter/material.dart';

import 'Homepage.dart';



void main()=>runApp(Flutterst1());
class Flutterst1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home:Homepage()
    );
  }
}
