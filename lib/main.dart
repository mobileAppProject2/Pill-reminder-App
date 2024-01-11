import 'package:flutter/material.dart';
import 'Account.dart';
import 'addPills.dart';
import 'loginScreen.dart';
import 'home_page.dart';

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
      home: LoginScreen(),
    );
  }
}

class HomePage extends StatefulWidget {
  final String email;
  const HomePage({Key? key, required this.email}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  List<Widget> screens = [];

  @override
  void initState() {
    super.initState();
    screens = [
      PillsPage(email: widget.email),
      Addpills(email: widget.email), // pass email to Addpills
      UserInfoPage(email: widget.email), // pass email to UserInfoPage
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      backgroundColor: Colors.white,
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