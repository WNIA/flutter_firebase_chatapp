import 'package:flutter/material.dart';
import 'package:testing_app/helper/constants.dart';
import 'package:testing_app/services/database.dart';
import 'package:testing_app/ui/ConversationPage.dart';
import 'package:testing_app/ui/SearchPage.dart';
import 'package:testing_app/widgets/widget.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  DatabaseMethods db = new DatabaseMethods();
  Stream charRoomStream;

  Widget chatRoomList() {
    return StreamBuilder(
      stream: charRoomStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return chatRoomTile(snapshot.data.docs[index]
                      .data()["chatroomID"]
                      .toString()
                      .replaceAll("_", "")
                      .replaceAll(Constants.myName, ""), snapshot.data.docs[index]
                      .data()["chatroomID"]);
                })
            : Container();
      },
    );
  }

  Widget chatRoomTile(String userName, String chatRoomID) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ConversationPage(chatRoomID)));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              child: Text("${userName.substring(0, 1).toUpperCase()}",
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(40)),
            ),
            SizedBox(
              width: 8.0,
            ),
            Text(
              userName,
              style: TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    db.getChatRooms(Constants.myName).then((value) {
      setState(() {
        charRoomStream = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarExit(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        backgroundColor: Colors.blueGrey,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SearchPage()));
        },
      ),
      body: chatRoomList(),
    );
  }
}
