import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tetris/screens/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tetris',
      theme: ThemeData(
        accentColor: Colors.indigo,
        primaryColor: Colors.indigoAccent,
      ),
      home: Home(),
    );
  }
}
