import 'package:flutter/material.dart';
import 'package:testing_app/helper/authenticate.dart';
import 'package:testing_app/helper/constants.dart';
import 'package:testing_app/helper/helperfunctions.dart';
import 'package:testing_app/services/firebase_auth.dart';

Widget appBarMain(BuildContext context) {
  return AppBar(
    elevation: 0.0,
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.black),
  );
}

Widget appBarExit(BuildContext context) {
  AuthMethods authMethods = new AuthMethods();
  return AppBar(
    elevation: 0.0,
    backgroundColor: Colors.white,
      title: Text(Constants.myName, style: TextStyle(color: Colors.blueGrey)),
    iconTheme: IconThemeData(color: Colors.black),
    actions: [
      GestureDetector(
        onTap: () {
          authMethods.signOut();
          HelperFunctions.saveUserLoggedInSharedPref(false);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Authenticate()));
        },
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.exit_to_app)),
      )
    ],
  );
}

Widget chatAppBar(BuildContext context, String chatRoomName) {
  return AppBar(
    elevation: 0.0,
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.black),
    title: Text(chatRoomName, style: TextStyle(color: Colors.blueGrey),),
  );
}

Widget submitButton(context, pressMethod, txt) {
  return new Container(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: SizedBox(
          height: 50,
          width: 100,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            textColor: Colors.white,
            color: Colors.pink,
            child: Text(txt),
            onPressed: pressMethod,
          )));
}

Widget navText(context, page, sentence, text) {
  return new Container(
      child: Row(
    children: <Widget>[
      Text(sentence),
      FlatButton(
        textColor: Colors.blue,
        child: Text(
          text,
          style: TextStyle(fontSize: 15),
        ),
        onPressed: page,
        // onPressed: () {
        //
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) => page),
        //   );
        // },
      )
    ],
    mainAxisAlignment: MainAxisAlignment.center,
  ));
}
