import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

final List<String> _account = [];
const String _baseURL = 'https://layalalfaraj.000webhostapp.com/Project2';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  bool _load = false;
  String _errorMessage = '';

  void update(bool success, [String? errorMessage]) {
    setState(() {
      _load = true; // show product list
      if (!success) {
        _errorMessage = errorMessage ?? 'Failed to load data';
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_errorMessage)));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    updateInfo(update);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Information'),
        centerTitle: true,
      ),
      body: _load
          ? const ListInfo()
          : const Center(
        child: SizedBox(
          width: 100,
          height: 100,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class ListInfo extends StatelessWidget {
  const ListInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _account.length,
      itemBuilder: (context, index) => Column(
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  _account[index],
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void updateInfo(Function(bool success, [String? errorMessage]) update) async {
  try {
    final url = Uri.parse('$_baseURL/account.php');
    final response = await http.get(url).timeout(const Duration(seconds: 5));
    _account.clear();
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      for (var row in jsonResponse) {
        _account.add('id: ${row['id']} name: ${row['name']} email: ${row['email']} password: ${row['password']} age: ${row['age']} gender: ${row['gender']}');
      }
      update(true);
    } else {
      update(false, 'Failed to load data. Status code: ${response.statusCode}');
    }
  } catch (e) {
    update(false, 'Failed to load data. Error: $e');
  }
}