import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUserByUserName(String username) async {
    return await FirebaseFirestore.instance.collection("Users").where("name", isEqualTo: username).get();
  }
  getUserByUserEmail(String userEmail) async {
    return await FirebaseFirestore.instance.collection("Users").where("email", isEqualTo: userEmail).get();
  }

  uploadUserInfo(userMap){
    FirebaseFirestore.instance.collection("Users").add(userMap).catchError((err){
      print(err.toString());
    });
  }
  createChatRoom(String chatRoomID, chatRoomMap){
    FirebaseFirestore.instance.collection("ChatRoom").doc(chatRoomID).set(chatRoomMap).catchError((err){
      print(err.toString());
    });
  }
}