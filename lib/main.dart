import 'package:flutter/material.dart';
import 'loginScreen.dart';
import 'home_page.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project 2',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white70,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primaryColor: Colors.white70,
        brightness: Brightness.light,
      ),
      home: HomePage(),
    );
  }
}