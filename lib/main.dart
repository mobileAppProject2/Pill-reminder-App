import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'account.dart';
import 'addPills.dart';
import 'loginScreen.dart';
import 'home_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project 2',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white70,
        brightness: Brightness.light,
      ),
      home: LoginPage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  List<Widget> screens = [
    const ShowPills(),
    const Addpills(),
    const Account(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      backgroundColor: Colors.grey,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() => currentIndex = value);
        },
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Add",
            icon: Icon(Icons.add),
          ),
          BottomNavigationBarItem(
            label: "Account",
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}