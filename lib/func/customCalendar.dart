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
    );
  }
}

Widget _calendar(_calendarController) {
  return new Container(
      child: TableCalendar(
          calendarController: _calendarController,
          calendarStyle: CalendarStyle()
      )
  );
}