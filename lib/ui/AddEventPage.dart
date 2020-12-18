import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class AddEvent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AddEventPage(),
    );
  }
}

class AddEventPage extends StatefulWidget {
  @override
  AddEventPageState createState() => AddEventPageState();
}

class AddEventPageState extends State<AddEventPage> {
  TextEditingController _eventController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
          child: Column(children: <Widget>[TextFormField(controller: _eventController), DateTimePicker()])),
    );
  }
}
