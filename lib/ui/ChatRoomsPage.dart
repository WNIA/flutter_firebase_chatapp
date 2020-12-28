import 'package:flutter/material.dart';
import 'package:testing_app/ui/SearchPage.dart';
import 'package:testing_app/widgets/widget.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarExit(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
        },
      ),
    );
  }
}
