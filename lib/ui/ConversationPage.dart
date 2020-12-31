import 'package:flutter/material.dart';
import 'package:testing_app/helper/constants.dart';
import 'package:testing_app/services/database.dart';
import 'package:testing_app/widgets/widget.dart';

class ConversationPage extends StatefulWidget {
  final String chatRoomID;

  ConversationPage(this.chatRoomID);

  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  DatabaseMethods db = new DatabaseMethods();
  TextEditingController msgController = new TextEditingController();

  Stream chatMsgStream;

  sendMsg() {
    if (msgController.text.isNotEmpty) {
      Map<String, dynamic> msgMap = {
        "message": msgController.text,
        "sentby": Constants.myName,
        "time": DateTime
            .now()
            .millisecondsSinceEpoch
      };
      db.addConversationMsgs(widget.chatRoomID, msgMap);
      msgController.text = "";
    }
  }

  Widget chatMessageList() {
    return StreamBuilder(
      stream: chatMsgStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        return snapshot.hasData ? ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              return messageTile(
                  snapshot.data.docs[index].data()["message"], snapshot.data.docs[index].data()["sentby"] == Constants.myName);
            }) : CircularProgressIndicator();
      },
    );
  }

  Widget messageTile(String message, bool isSentByMe) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
      child: Text(message),
    );
  }

  @override
  void initState() {
    db.getConversationMsgs(widget.chatRoomID).then((value) {
      setState(() {
        chatMsgStream = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Stack(
          children: [
            chatMessageList(),
            Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: msgController,
                      decoration: InputDecoration(
                          labelText: "Enter Message",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                  ),
                  FlatButton(
                      onPressed: () {
                        sendMsg();
                      },
                      color: Colors.white,
                      minWidth: 10,
                      height: 40,
                      child: Icon(Icons.send))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
