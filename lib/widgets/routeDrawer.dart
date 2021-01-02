import 'package:flutter/material.dart';

Widget routeDrawer(BuildContext context, String title) {
  return Drawer(
    child: ListView(
      padding: const EdgeInsets.all(0.0),
      children: [
        DrawerHeader(child: Text('Menu'))
      ],
    ),
  );
}