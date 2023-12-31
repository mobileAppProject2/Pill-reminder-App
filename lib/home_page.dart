import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project2/widget.dart';
import 'Theme.dart';
import 'package:flutter/services.dart';
import 'widget.dart';
import 'addPills.dart';
import 'loginScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Pills',
          style: TextStyle(
            fontSize: 20.0, // Adjust the font size as needed
            fontWeight: FontWeight.bold, // Adjust the font weight as needed
          ),
        ),
        backgroundColor: Color(0xFFFFDAB3),
        // Adjust the background color as needed
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // Navigate to LoginScreen when the person icon is pressed
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xfff8f5f5),
                      Color(0xffffdab3),
                      Color(0xffdcb082),
                      Color(0xFFD5B68F),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  _addPills(),
                ],
              ),
            ],
          ),
        ),
      ), // Add missing closing parenthesis here
    );
  }


  Widget _addPills() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      // Adjust margin as needed
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(DateFormat.yMMMd().format(DateTime.now()),
                    style: subHeadingStyle),
                Text("Today", style: HeadingStyle),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Navigate to Addpills page when the button is pressed
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Addpills()),
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Color(0xFFFFDAB3), // Set the background color
              textStyle: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black26,
              ),
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
            ),
            child: Text("Add Pills"),
          ),
        ],
      ),
    );
  }
}
