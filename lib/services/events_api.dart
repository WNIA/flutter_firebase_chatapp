import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:testing_app/model/events_model.dart';

// String url = 'https://jsonplaceholder.typicode.com/posts';
String url = 'https://wnia.github.io/event.json';

Future<List<Events>> fetchEvents(http.Client client) async {
  final response = await client.get(url);
  return compute(parseEvents, response.body);
}

List<Events> parseEvents(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>> ();
  return parsed.map<Events>((json) => Events.fromJson(json)).toList();
}
