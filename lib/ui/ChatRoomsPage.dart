import 'package:flutter/material.dart';
import 'package:testing_app/services/firebase_auth.dart';
import 'package:testing_app/widgets/widget.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethods authMethods = new AuthMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarExit(context),

    );
  }
}
