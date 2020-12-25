import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:testing_app/models/login_model.dart';

// ignore: camel_case_types
class login_api {
  Future<LoginResponse> login(LoginRequest logreq) async {
    String url = "https://reqres.in/api/login";

    final response = await http.post(url, body: logreq.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      return LoginResponse.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to load data!');
    }
  }
}
