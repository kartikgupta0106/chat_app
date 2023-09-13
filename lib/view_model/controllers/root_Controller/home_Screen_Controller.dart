

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../service/auth_service/auth_Service.dart';

class HomeController extends GetxController{

  late String currentUser;
  late String roomId;


  late bool exist;

  Future<bool> checkExist(String docID) async {
      await FirebaseFirestore.instance.doc("chats_room/$docID").get().then((doc) {
        exist = doc.exists;
      });
      return exist;
  }

  Future<void> createChatRoom(String receiverId , String receiverName) async {
    roomId = currentUser.compareTo(receiverId) == -1 ? roomId = currentUser + receiverId : receiverId + currentUser;
    if(await checkExist(roomId) == false){
      FirebaseFirestore.instance.collection('chats_room').doc(roomId).collection("massage").add({"message":"hi"});
      FirebaseFirestore.instance.collection('chats_room').doc(roomId).set({"userFirstId":currentUser , "userSecondId":receiverId , "userFirstName" : Get.find<AuthService>().currentUserName , "userSecondName":receiverName});
    }
  }
  @override
  void onInit() {
    currentUser = Get.find<AuthService>().currentUserId;
    super.onInit();
  }
}