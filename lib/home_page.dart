import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String _baseURL = 'https://layalalfaraj.000webhostapp.com/Project2';

class PillsPage extends StatefulWidget {
  final String email;
  const PillsPage({Key? key, required this.email}) : super(key: key);

  @override
  _PillsPageState createState() => _PillsPageState();
}

class _PillsPageState extends State<PillsPage> {
  List<dynamic> pills = [];

  @override
  void initState() {
    super.initState();
    fetchPills();
  }

  Future<void> fetchPills() async {
    try {
      final response = await http.post(
        Uri.parse('$_baseURL/getPill.php'),
        body: {'email': widget.email},
      );
      if (response.statusCode == 200) {
        final dynamic data = jsonDecode(response.body);
        final bool success = data['success'];
        if (success) {
          setState(() {
            pills = data['data'];
          });
        }
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> deletePill(String pillId) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseURL/deletePill.php'),
        body: {'email': widget.email},
      );
      if (response.statusCode == 200) {
        final dynamic data = jsonDecode(response.body);
        final bool success = data['success'];
        if (success) {
          // Pill successfully deleted from the database
          // Perform any necessary actions or show a success message
          fetchPills(); // Refresh the list of pills after deletion
        } else {
          // Deletion failed
          // Show an error message or perform any necessary error handling
        }
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Number of Pills: ${pills.length}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
            ),
            itemCount: pills.length,
            itemBuilder: (context, index) {
              final pill = pills[index];
              return Card(
                color: Colors.pink[50],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(
                        pill['name'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Note: ${pill['note']}'),
                          Text('Start Time: ${pill['startTime']}'),
                          Text('End Time: ${pill['endTime']}'),
                          Text('Remind: ${pill['remind']}'),
                          Text('Repeat: ${pill['repeat']}'),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          final pillId = pill['id'].toString();
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Delete Pill'),
                                content: Text('Are you sure you want to delete this pill?'),
                                actions: [
                                  TextButton(
                                    child: Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Delete'),
                                    onPressed: () {
                                      deletePill(pillId);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}