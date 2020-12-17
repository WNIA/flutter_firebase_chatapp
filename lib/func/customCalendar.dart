import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class customCalendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: customCalendarPage(),
    );
  }
}

// ignore: camel_case_types
class customCalendarPage extends StatefulWidget {
  @override
  customCalendarState createState() => customCalendarState();
}

// ignore: camel_case_types
class customCalendarState extends State<customCalendarPage> {
  CalendarController _calendarController;
  TextEditingController _eventController;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _eventController = TextEditingController();
    _events = {};
    _selectedEvents = [];
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _calendar(_calendarController, _events),
            _eventbox(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF7E57C2),
        splashColor: Color(0xFF4527A0),
        child: Icon(Icons.add),
        onPressed: _addEvents,
      ),
    );
  }

  _addEvents() async {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
                content: TextField(controller: _eventController),
                actions: <Widget>[
                  FlatButton(
                    onPressed: (){
                      if(_eventController.text.isEmpty) return;
                      setState(() {
                        if(_events[_calendarController.selectedDay] != null) {
                          _events[_calendarController.selectedDay].add(_eventController.text);
                        }
                        else{
                          _events[_calendarController.selectedDay] = [_eventController.text];
                        }
                        _eventController.clear();
                        Navigator.pop(context);
                      });
                    },
                    child: Text('Save'),
                  ),
                ]));
  }
}

Widget _calendar(_calendarController, _events) {
  return new Container(
      child: TableCalendar(
    events: _events,
    calendarController: _calendarController,
    calendarStyle: CalendarStyle(
      selectedColor: Color(0xFF000000),
      todayColor: Color(0xFF7E57C2),
    ),
    daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle(fontWeight: FontWeight.bold),
        weekdayStyle: TextStyle(fontWeight: FontWeight.bold)),
    headerStyle: HeaderStyle(
      formatButtonShowsNext: false,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    ),
  ));
}

Widget _eventbox() {
  return Container();
}

Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
  Map<String, dynamic> newMap = {};
  map.forEach((key, value) {
    newMap[key.toString()] = map[key];
  });
  return newMap;
}

Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
  Map<DateTime, dynamic> newMap = {};
  map.forEach((key, value) {
    newMap[DateTime.parse(key)] = map[key];
  });
  return newMap;
}
