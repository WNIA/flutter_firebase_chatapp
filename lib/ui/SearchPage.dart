import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing_app/helper/constants.dart';
import 'package:testing_app/services/database.dart';
import 'package:testing_app/ui/ConversationPage.dart';
import 'package:testing_app/widgets/text_widget.dart';
import 'package:testing_app/widgets/widget.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  DatabaseMethods dbm = new DatabaseMethods();

  QuerySnapshot searchSnapShot;

  searchUser() {
    dbm.getUserByUserName(searchController.text).then((val) {
      setState(() {
        searchSnapShot = val;
        print(searchSnapShot);
      });
    });
  }

  createChatRoomStartConversation({String username}) {
    print('${Constants.myName}');
    if(username != Constants.myName) {
      String chatRoomID = getChatRoomID(username, Constants.myName);
      List<String> users = [username, Constants.myName];
      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatroomID": chatRoomID
      };
      dbm.createChatRoom(chatRoomID, chatRoomMap);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ConversationPage()));
    }else{
      print("That's your account");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                          labelText: "Search",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                  ),
                  FlatButton(
                      onPressed: () {
                        searchUser();
                      },
                      color: Colors.white,
                      minWidth: 10,
                      height: 40,
                      child: Icon(Icons.search))
                ],
              ),
            ),
            searchList()
          ],
        ),
      ),
    );
  }

  Widget searchList() {
    return searchSnapShot != null
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchSnapShot.docs.length,
            itemBuilder: (context, index) {
              return searchTile(
                  userName: searchSnapShot.docs[index].data()["name"],
                  userEmail: searchSnapShot.docs[index].data()["email"]
                  // map: searchSnapShot.docs[index].data(),
                  );
            })
        : Container();
  }

  Widget searchTile({String userName, String userEmail}){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: ListTile(
        title: Text(userName),
        subtitle: Text(userEmail),
        trailing: GestureDetector(
          onTap: () {
            createChatRoomStartConversation(username: userName);
          },
          child: Container(
              height: 40,
              width: 50,
              decoration: BoxDecoration(
                  color: Colors.deepPurpleAccent,
                  borderRadius: BorderRadius.circular(15)),
              child: text1('Chat', Colors.white, FontWeight.bold, 12.0)),
        ),
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.deepPurple,
        ),
      ),
    );

  }
}

getChatRoomID(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
