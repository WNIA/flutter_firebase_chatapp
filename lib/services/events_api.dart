import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:testing_app/models/events_model.dart';

// String url = 'https://jsonplaceholder.typicode.com/posts';
String url = 'https://wnia.github.io/event.json';

Future<List<EventsModel>> fetchEvents(http.Client client) async {
  final response = await client.get(url);
  return compute(parseEvents, response.body);
}

List<EventsModel> parseEvents(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>> ();
  return parsed.map<EventsModel>((json) => EventsModel.fromJson(json)).toList();
}
