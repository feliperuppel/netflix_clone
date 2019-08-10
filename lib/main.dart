import 'package:flutter/material.dart';
//import 'package:flutter/foundation.dart';

import 'HomePage.dart';



void main()=>runApp(Flutterst1());
class Flutterst1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
//        theme: defaultTargetPlatform == TargetPlatform.iOS
//            ? kIOSTheme
//            : kDefaultTheme,
        home:Homepage()
    );
  }
}
