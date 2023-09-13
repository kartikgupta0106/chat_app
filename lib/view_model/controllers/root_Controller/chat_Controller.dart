import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ChatController extends GetxController {
  String secondUserId = "";
  final box = GetStorage();
  late String currentUser;
  late String roomId;

  TextEditingController textEditingController = TextEditingController();


  void sendMessage() {
      if(textEditingController.text.trim().isNotEmpty){
          FirebaseFirestore.instance.collection('chats_room').doc(roomId).collection("massage").add({"message":textEditingController.text.trim() , "timestamp": Timestamp.now().microsecondsSinceEpoch, "userId" : currentUser});
      }
  }

  @override
  void onInit() {
    secondUserId = Get.arguments ?? "0";
    currentUser = box.read('userData')['id'];
    roomId = currentUser.compareTo(secondUserId) == -1 ? roomId = currentUser + secondUserId : secondUserId + currentUser;
    super.onInit();
  }
}
