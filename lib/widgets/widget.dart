import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context) {
  return AppBar(
    elevation: 0.0,
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.black),
  );
}

Widget submitButton(context, page, txt) {
  return new Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
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
            onPressed: () {
              // if (validateAndSave(globalFormKey)) {
              //   print(loginRequest.toJson());
              // }
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => page),
              );
            },
          )));
}

Widget NavText(context, page, sentence, text) {
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => page),
              );
            },
          )
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ));
}