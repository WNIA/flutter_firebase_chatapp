import 'package:flutter/material.dart';
import 'package:testing_app/model/events_model.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:testing_app/services/events_api.dart';

class CustomCalendar extends StatefulWidget {
  @override
  CustomCalendarPage createState() => CustomCalendarPage();
}

class CustomCalendarPage extends State<CustomCalendar> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: FutureBuilder<List<Events>>(
        future: fetchEvents(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? EventList(snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
      // body: CustomCalendarPage(),
    );
  }

  Widget EventList(List<Events> events) {
    return Container(
      child: SfCalendar(
        view: CalendarView.month,
        showNavigationArrow: true,
        dataSource: MeetingDataSource(events),
        cellEndPadding: 0,
        monthViewSettings: MonthViewSettings(appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
      ),
    );
  }
}
class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Events> events) {
    appointments = events;
  }

  @override
  String getSubject(int index) {
    // TODO: implement getSubject
    return appointments[index].title;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    // TODO: implement getEndTime
    return appointments[index].to;
  }

  @override
  Color getColor(int index) {
    // TODO: implement getColor
    return Colors.orange;
  }
}
