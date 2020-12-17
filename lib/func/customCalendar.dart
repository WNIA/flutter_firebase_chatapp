import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class customCalendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: customCalendarPage(),
    );
  }
}

class customCalendarPage extends StatefulWidget {
  @override
  customCalendarState createState() => customCalendarState();
}

class customCalendarState extends State<customCalendarPage> {
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
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
            _calendar(_calendarController),
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
}

Widget _calendar(_calendarController) {
  return new Container(
      child: TableCalendar(
          calendarController: _calendarController,
          calendarStyle: CalendarStyle(
            selectedColor: Color(0xFF000000),
            todayColor: Color(0xFF7E57C2)
          )
      )
  );
}

_addEvents() async {
  
}