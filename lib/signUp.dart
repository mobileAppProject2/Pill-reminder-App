import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'main.dart';

// domain of your server
const String _baseURL = 'https://layalalfaraj.000webhostapp.com/Project2';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // creates a unique key to be used by the form
  // this key is necessary for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();
  TextEditingController _controllerAge = TextEditingController();
  TextEditingController _controllerGender = TextEditingController();
  // the below variable is used to display the progress bar when retrieving data
  bool _loading = false;


  @override
  void dispose() {
    _controllerName.dispose();
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    _controllerAge.dispose();
    _controllerGender.dispose();
    super.dispose();
  }

  void update(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
    setState(() {
      _loading = false;
    });
  }
  void Signup(Function(String text) update, String name, String email, String password, int age, String gender) async {
    try {
      // we need to first retrieve and decrypt the key
      // send a JSON object using http post
      final response = await http.post(
          Uri.parse('$_baseURL/signUp.php'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: convert.jsonEncode(<String, String>{
            'name': '$name', 'email': email, 'password':'$password', 'age':'$age', 'gender':'$gender', 'key': 'your_key'
          })).timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        // if successful, call the update function
        update(response.body);

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HomePage(email: email),
        ));
      }
    }
    catch(e) {
      update(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        key: _formKey, // key to uniquely identify the form when performing validation
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background/login.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                SizedBox(height: 24.0),
                TextFormField(
                controller: _controllerName,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8),
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _controllerEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8),
                  labelText: 'Email Address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _controllerPassword,
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8),
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _controllerAge,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8),
                  labelText: 'Age',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                ),
                validator: (String? value) {
                  if (value == null ||value.isEmpty) {
                    return 'Please enter an age';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _controllerGender,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8),
                  labelText: 'Gender',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a gender';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Signup(update, _controllerName.text, _controllerEmail.text, _controllerPassword.text, int.parse(_controllerAge.text), _controllerGender.text);
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF6852B2),
                  padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
              SizedBox(height: 16.0),
              buildLoginBtn(),
            ],
          ),
        ),
      ),
    );
  }
  Widget buildLoginBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Already have an account? ',
              style: TextStyle(color: Colors.black54, fontSize: 18.0),
            ),
            TextSpan(
              text: 'Login',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


