import 'package:chatting_app/view/widgets/text_field/common_text_field.dart';
import 'package:chatting_app/view_model/controllers/root_Controller/chat_Controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/messageBox/message_box.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    ChatController controller = Get.put(ChatController());
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Chat"),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('chats_room').doc(controller.roomId).collection('massage').orderBy('timestamp').snapshots(),
              builder: (context, snapshot) {
                List message = snapshot.data?.docs.reversed.toList()??[];
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if(snapshot.data?.docs.isNotEmpty??false){
                  return ListView.builder(
                    reverse: true,
                    shrinkWrap: false,
                    padding: const EdgeInsets.all(10.0),
                    itemBuilder: (context, index) {
                      // controller.scrollToBottom();
                      return  ChatBubble(text: message[index]['message']??"", isCurrentUser: message[index]['userId']==controller.currentUser);
                    },
                    // CustomSendMessageUI(sendMsgTxt: snapshot.data?.docs[index]['message']??"" , time: snapshot.data?.docs[index]['timestamp'].toString()??"",),
                    // Container(child: Text("${snapshot.data?.docs[index]['message']??""}" , style: const TextStyle(color: Colors.white),),),
                    itemCount: message.length ?? 0,
                  );
                }
                else{
                  return const SizedBox();
                }
              },
            ),
          ),
          Container(
            height: 50,
            width: width - 10,
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.redAccent),
            child: Row(
              children: [
                SizedBox(
                    width: width / 1.2,
                    child: CommonTextField(
                      hintText: "Enter Text",
                      controller: controller.textEditingController,
                    )),
                const Spacer(),
                InkWell(
                  onTap: () {
                    controller.sendMessage();
                    controller.textEditingController.clear();
                  },
                  child: const Icon(Icons.send),
                ),
                const SizedBox(
                  width: 20,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    Key? key,
    required this.text,
    required this.isCurrentUser,
  }) : super(key: key);
  final String text;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      // asymmetric padding
      padding: EdgeInsets.fromLTRB(
        isCurrentUser ? 64.0 : 16.0,
        4,
        isCurrentUser ? 16.0 : 64.0,
        4,
      ),
      child: Align(
        // align the child within the container
        alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
        child: DecoratedBox(
          // chat bubble decoration
          decoration: BoxDecoration(
            color: isCurrentUser ? Colors.blue : Colors.grey[300],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: isCurrentUser ? Colors.white : Colors.black87),
            ),
          ),
        ),
      ),
    );
  }
}