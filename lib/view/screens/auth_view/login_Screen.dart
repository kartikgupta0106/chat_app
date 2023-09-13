import 'package:chatting_app/view/widgets/buttons/inkwell_Button.dart';
import 'package:chatting_app/view/widgets/text_field/common_text_field.dart';
import 'package:chatting_app/view_model/routes/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../view_model/controllers/auth_Controller/login_Controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginController controller =Get.put(LoginController());
    return Scaffold(
      appBar: AppBar(
        title:  const Text("Login Screen" , style: TextStyle(fontSize: 20 , color: Colors.black87),),
      ),
      body: Column(
        children: [
          Center(child: CommonTextField(hintText: "Enter Name" , controller: controller.username,)),
          Center(child: CommonTextField(hintText: "Enter Email" , controller: controller.email,  keyboardType: TextInputType.emailAddress,)),
          Center(child: CommonTextField(hintText: "Enter Password" , controller: controller.password, )),
          const SizedBox(height: 10,),
          InkWellButton(text: "SignIn", onPressed: (){controller.signUpUser();}),
          const SizedBox(height: 50,),
          InkWellButton(text: "SIGN IN WITH GOOGLE", onPressed: (){
            controller.googleSignInFunction();
          }),
        ],
      ),
    );
  }
}
