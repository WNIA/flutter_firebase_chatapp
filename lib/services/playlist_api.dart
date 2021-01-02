import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:testing_app/models/playlist_model.dart';

String url = 'https://wnia.github.io/playlist.json';

Future<List<PlayListModel>> fetchPlayList(http.Client client) async{
  final response = await client.get(url);
  if(response.statusCode == 200) {
    return compute(parsePlayList, response.body);
  } else{
    throw Exception('Unable to fetch Data from rest api');
  }
}

List<PlayListModel> parsePlayList(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>> ();
  return parsed.map<PlayListModel>((json) => PlayListModel.fromJson(json)).toList();
}
