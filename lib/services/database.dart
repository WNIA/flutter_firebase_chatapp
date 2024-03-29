import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUserByUserName(String username) async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .where("name", isEqualTo: username)
        .get();
  }

  getUserByUserEmail(String userEmail) async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .where("email", isEqualTo: userEmail)
        .get();
  }

  uploadUserInfo(userMap) {
    FirebaseFirestore.instance
        .collection("Users")
        .add(userMap)
        .catchError((err) {
      print(err.toString());
    });
  }

  createChatRoom(String chatRoomID, chatRoomMap) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomID)
        .set(chatRoomMap)
        .catchError((err) {
      print(err.toString());
    });
  }

  addConversationMsgs(String chatRoomID, msgMap) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomID)
        .collection("chats")
        .add(msgMap)
        .catchError((err) {
      print(err.toString());
    });
  }

  getConversationMsgs(String chatRoomID) async {
    return await FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomID)
        .collection("chats")
        .orderBy("time")
        .snapshots();
  }

  getChatRooms(String userName) async {
    return await FirebaseFirestore.instance
        .collection("ChatRoom")
        .where("users", arrayContains: userName)
        .snapshots();
  }
}
