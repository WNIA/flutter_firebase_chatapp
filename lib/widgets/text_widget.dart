import 'package:flutter/material.dart';

Widget text1(text, color, weight, size) {
  return new Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Text(
        text,
        style: TextStyle(
            color: color, fontWeight: weight, fontSize: size),
      ));
}
