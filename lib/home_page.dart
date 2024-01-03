import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

final List<String> _pills = [];
// domain of your server
const String _baseURL = 'https://layalalfaraj.000webhostapp.com';

class ShowPills extends StatefulWidget {
  const ShowPills({Key? key}) : super(key: key);

  @override
  State<ShowPills> createState() => _ShowPillsState();
}

class _ShowPillsState extends State<ShowPills> {
  bool _load = false;

  void update(bool success) {
    setState(() {
      _load = true; // show product list
      if (!success) { // API request failed
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('failed to load data')));
      }
    });
  }

  @override
  void initState() {
    // update data when the widget is added to the tree for the first time.
    updatePills(update);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pills'),
        centerTitle: true,
      ),
      body: _load
          ? const ListPills()
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

class ListPills extends StatelessWidget {
  const ListPills({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _pills.length,
      itemBuilder: (context, index) => Column(
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  _pills[index],
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

void updatePills(Function(bool success) update) async {
  try {
    final url = Uri.https(_baseURL, 'getPill.php');
    final response = await http.get(url).timeout(const Duration(seconds: 5)); // max timeout 5 seconds
    _pills.clear(); // clear old products
    if (response.statusCode == 200) {
      // if successful call
      final jsonResponse = convert.jsonDecode(response.body);
      for (var row in jsonResponse) {
        _pills.add('name: ${row['name']} note: ${row['note']} startTime: ${row['startTime']} endTime: ${row['endTime']} remind: ${row['remind']} repeat: ${row['repeat']}');
      }
      update(true); // callback update method to inform that we completed retrieving data
    }
  } catch (e) {
    update(false); // inform through callback that we failed to get data
  }
}


