import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Theme.dart';
import 'input_field.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

const String _baseURL = 'https://layalalfaraj.000webhostapp.com/Project2';

class Addpills extends StatefulWidget {
  final String email;
  const Addpills({Key? key, required this.email}) : super(key: key);

  @override
  _AddpillsState createState() => _AddpillsState();
}
class _AddpillsState extends State<Addpills> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerNote = TextEditingController();
  TextEditingController _controllerStartTime = TextEditingController();
  TextEditingController _controllerEndTime = TextEditingController();
  TextEditingController _controllerRemind = TextEditingController();
  TextEditingController _controllerRepeat = TextEditingController();
  // the below variable is used to display the progress bar when retrieving data
  bool _loading = false;

  DateTime _selectedDate = DateTime.now();
  String _endTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selesctRemid = 5;
  String _selesctRepeat = 'None';
  List<int> reminderList = [5, 10, 15, 20];
  List<String> repeatList = ["None", "Daily", "Weekly", "Monthly"];


  @override
  void dispose() {
    _controllerName.dispose();
    _controllerNote.dispose();
    _controllerStartTime.dispose();
    _controllerEndTime.dispose();
    _controllerRemind.dispose();
    _controllerRepeat.dispose();
    super.dispose();
  }
  void update(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
    setState(() {
      _loading = false;
    });
  }

  void AddPill(
      Function(String text) update,
      String name,
      String note,
      String startTime,
      String endTime,
      String remind,
      String repeat) async {
    try {
      final Map<String, String> data = {
        'email': widget.email,
        'name': name,
        'note': note,
        'startTime': startTime,
        'endTime': endTime,
        'remind': remind,
        'repeat': repeat,
        'key': 'your_key',
      };

      final response = await http.post(
        Uri.parse('$_baseURL/addPill.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: convert.jsonEncode(data),
      ).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        update(response.body);
      }
    } catch (e) {
      update(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Add pills",
                style: HeadingStyle,
              ),
              MyInputField(
                  controller: _controllerName,
                  title: 'name',
                  hint: 'Enter a name'
              ),
              MyInputField(
                  controller: _controllerNote,
                  title: 'Note',
                  hint: 'Enter your note'
              ),
              Row(
                children: [
                  Expanded(
                    child: MyInputField(
                      controller: _controllerStartTime,
                      title: 'Start Date',
                      hint: _startTime,
                      widget: IconButton(
                        onPressed: () {
                          _getTimeFromUser(isStartedTime: true);
                        },
                        icon: Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: MyInputField(
                      controller: _controllerEndTime,
                      title: 'End Date',
                      hint: _endTime,
                      widget: IconButton(
                        onPressed: () {
                          _getTimeFromUser(isStartedTime: false);
                        },
                        icon: Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              MyInputField(
                controller: _controllerRemind,
                title: 'Remind',
                hint: '$_selesctRemid minutes early',
                widget: DropdownButton(
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.black26,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  underline: Container(
                    height: 0,
                  ),
                  style: subTitleStyle,
                  value: _selesctRemid.toString(),
                  onChanged: (String? value) {
                    setState(() {
                      _selesctRemid = int.parse(value ?? '5');
                    });
                  },
                  items: reminderList.map<DropdownMenuItem<String>>((int value) {
                    return DropdownMenuItem<String>(
                      value: value.toString(),
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
              ),
              MyInputField(
                controller: _controllerRepeat,
                title: 'Repeat',
                hint: '$_selesctRepeat',
                widget: DropdownButton(
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.black26,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  underline: Container(
                    height: 0,
                  ),
                  style: subTitleStyle,
                  value: _selesctRepeat,
                  onChanged: (String? value) {
                    setState(() {
                      _selesctRepeat = value ?? 'None';
                    });
                  },
                  items: repeatList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  AddPill(
                    update,
                    _controllerName.text,
                    _controllerNote.text,
                    _startTime,
                    _endTime,
                    _selesctRemid.toString(),
                    _selesctRepeat,
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF6852B2),
                  padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  'Add',
                  style: TextStyle(fontSize: 15.0, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getDateForUser() async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2025),
    );
    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    } else {
      print("It is null or something wrong");
    }
  }

  _getTimeFromUser({required bool isStartedTime}) async {
    TimeOfDay? pickedTime = await _showTimePicker();

    if (pickedTime != null) {
      String formattedTime = _formatTime(pickedTime);

      if (isStartedTime) {
        setState(() {
          _startTime = formattedTime;
        });
      } else {
        setState(() {
          _endTime = formattedTime;
        });
      }
    } else {
      print('Time Canceled');
    }
  }

  _showTimePicker() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.input,
      initialTime: TimeOfDay(
        hour: int.parse(_startTime.split(":")[0]),
        minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
      ),
    );
    return pickedTime;
  }

  String _formatTime(TimeOfDay time) {
    int hour = time.hourOfPeriod;
    int minute = time.minute;

    String period = time.period == DayPeriod.am ? 'AM' : 'PM';

    return '$hour:${minute.toString().padLeft(2, '0')} $period';
  }
}



