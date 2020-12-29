import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing_app/services/database.dart';
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
              return SearchTile(
                  userName: searchSnapShot.docs[index].data()["name"],
                  userEmail: searchSnapShot.docs[index].data()["email"]
                // map: searchSnapShot.docs[index].data(),
                  );
            })
        : Container();
  }
}

class SearchTile extends StatelessWidget {
  final String userName;
  final String userEmail;
  final Map<String, dynamic> map;

  SearchTile({this.userName, this.userEmail, this.map});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: ListTile(
        title: Text(userName),
        subtitle: Text(userEmail),
        trailing: GestureDetector(
          onTap: (){
            
          },
          child: Container(
            height: 40,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.deepPurpleAccent,
              borderRadius: BorderRadius.circular(15)
            ),
              child: text1('Chat', Colors.white, FontWeight.bold, 12.0)),
        ),
        leading: CircleAvatar(radius: 30, backgroundColor: Colors.deepPurple,),
      ),
    );
  }
}
