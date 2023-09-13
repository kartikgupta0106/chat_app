import 'package:chatting_app/view/widgets/profile_box/profile_Box.dart';
import 'package:chatting_app/view_model/routes/routes/app_pages.dart';
import 'package:chatting_app/view_model/service/auth_service/auth_Service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../view_model/controllers/root_Controller/home_Screen_Controller.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text("Home Screen"),
            const Spacer(),
            Text(Get.find<AuthService>().currentUserName)
          ],
        ),

      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(Colors.deepPurpleAccent),
              ),
            );
          } else if(snapshot.data?.docs.isNotEmpty??false){
            return ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemBuilder: (context, index) => snapshot.data?.docs[index].id != controller.currentUser ? ProfileBox(
                onTap: (){
                  controller.createChatRoom(snapshot.data?.docs[index].id??"" , snapshot.data?.docs[index]['nickname']??"");
                  Get.toNamed(Routes.chat , arguments: snapshot.data?.docs[index].id??"");
                },
                  name: snapshot.data?.docs[index]['nickname']??"",
                  imageUrl: snapshot.data?.docs[index]['photoUrl']??"",
                  width: width) : const SizedBox(),
              itemCount: snapshot.data?.docs.length ?? 0,
            );
          }
          else{
            return const SizedBox();
          }
        },
      ),
    );
  }
}
