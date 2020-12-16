import 'package:flutter/material.dart';
import 'package:testing_app/ui/LoginPage.dart';
import 'package:overlay_support/overlay_support.dart';


void main() {
  // runApp(MyApp());
  runApp(OverlaySupport(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      //home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

