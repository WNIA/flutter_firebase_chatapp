import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUserByUserName(String username) async {
    return await FirebaseFirestore.instance.collection("Users").where("name", isEqualTo: username).get();
  }
  uploadUserInfo(userMap){
    FirebaseFirestore.instance.collection("Users").add(userMap).catchError((err){
      print(err.toString());
    });
  }
}