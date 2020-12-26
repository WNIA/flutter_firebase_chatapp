import 'package:flutter/material.dart';
import 'package:testing_app/models/events_model.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:testing_app/services/events_api.dart';
import 'package:testing_app/widgets/widget.dart';

class CustomCalendar extends StatefulWidget {
  @override
  CustomCalendarPage createState() => CustomCalendarPage();
}

class CustomCalendarPage extends State<CustomCalendar> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: FutureBuilder<List<EventsModel>>(
        future: fetchEvents(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? eventList(snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
      // body: CustomCalendarPage(),
    );
  }

  Widget eventList(List<EventsModel> events) {
    return Container(
      padding: const EdgeInsets.all(10 ),
      child: SfCalendar(
        view: CalendarView.month,
        showNavigationArrow: true,
        dataSource: MeetingDataSource(events),
        cellEndPadding: 0,
        monthViewSettings: const MonthViewSettings(appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
      ),
    );
  }
}
class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<EventsModel> events) {
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
