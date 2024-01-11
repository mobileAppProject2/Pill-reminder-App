import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'loginScreen.dart';

const String _baseURL = 'https://layalalfaraj.000webhostapp.com/Project2';

class UserInfoPage extends StatefulWidget {
  final String email;
  const UserInfoPage({Key? key, required this.email}) : super(key: key);

  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  List<dynamic> userInfo = [];

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final response = await http.post(
        Uri.parse('$_baseURL/account.php'),
        body: {'email': widget.email},
      );
      if (response.statusCode == 200) {
        final dynamic data = jsonDecode(response.body);
        final bool success = data['success'];
        if (success) {
          setState(() {
            userInfo = data['data'];
          });
        }
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> deleteAccount() async {
    try {
      final response = await http.post(
        Uri.parse('$_baseURL/deleteAccount.php'),
        body: {'email': widget.email},
      );

      if (response.statusCode == 200) {
        Navigator.pushReplacementNamed(context, '/login');
      } else {
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove the back button
        centerTitle: true,
        title: Text('Your Account'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hello ${userInfo[0]['name']}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  '${userInfo[0]['id']}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 1,
              ),
              itemCount: userInfo.length,
              itemBuilder: (context, index) {
                final user = userInfo[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('email: ${user['email']}'),
                          Text('age: ${user['age']}'),
                          Text('gender: ${user['gender']}'),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: deleteAccount,
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF6852B2),
                            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            'Delete',
                            style: TextStyle(fontSize: 15.0, color: Colors.white),
                          ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ));
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF6852B2),
                            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            'Logout',
                            style: TextStyle(fontSize: 15.0, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}