import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

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
  TextEditingController _eventController = TextEditingController();
  Map<DateTime, List<dynamic>> _events = {};
  List<dynamic> _selectedEvents = [];

  // final selectedDay = DateTime.now();

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

  void _ondayselected(DateTime day, List events, List holidays) {
    setState(() {
      _selectedEvents = events;
    });
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
            _calendar(),
            SizedBox(height: 10),
            ..._selectedEvents.map((event) => Card(
                elevation: 0.0,
                child: InkWell(
                  onTap: (){
                    InkRipple.splashFactory;
                  },
                child: ListTile(
                  title: Text(event,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ))))
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

  Widget _calendar() {
    return new Container(
      child: TableCalendar(
        events: _events,
        calendarController: _calendarController,
        calendarStyle: CalendarStyle(
          selectedColor: Color(0xFF7E57C2),
          todayColor: Colors.deepOrange,
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
        onDaySelected: _ondayselected,
      ),
    );
  }

  _addEvents() async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(
                controller: _eventController,
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("Save"),
                  onPressed: () {
                    if (_eventController.text.isEmpty) return;
                    if (_events[_calendarController.selectedDay] != null) {
                      _events[_calendarController.selectedDay]
                          .add(_eventController.text);
                    } else {
                      _events[_calendarController.selectedDay] = [
                        _eventController.text
                      ];
                    }
                    _eventController.clear();
                    Navigator.pop(context);
                  },
                )
              ],
            ));
    setState(() {
      _selectedEvents = _events[_calendarController.selectedDay];
    });
  }
}
