import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUserByUserName(String username) {

  }
  uploadUserInfo(userMap){
    FirebaseFirestore.instance.collection("Users").add(userMap).catchError((err){
      print(err.toString());
    });
  }
}