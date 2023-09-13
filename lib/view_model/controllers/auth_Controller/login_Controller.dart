import 'package:chatting_app/view_model/routes/routes/app_pages.dart';
import 'package:chatting_app/view_model/service/auth_service/auth_Service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {


  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  void signUpUser() async {
    try {
      UserCredential userCred = await auth
          .createUserWithEmailAndPassword(
          email: email.text, password: password.text);


      // After that access "users" Firestore in firestore and save username, email and userLocation
      // # 3
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCred.user!.uid)
          .set(
        {
          'nickname': username.text,
          'id': auth.currentUser?.uid ?? "",
          'photoUrl': 'https://icon-library.com/images/default-user-icon/default-user-icon-4.jpg'
        },
      );
    }
    catch(e){
      print("---------------------------------- error-> $e");
    }
  }

  Future<void> googleSignInFunction() async {
        await GoogleSignIn().signIn().then((GoogleSignInAccount ?googleSignInAccount)async{
          if (googleSignInAccount != null) {
            final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
            await FirebaseAuth.instance.signInWithCredential(GoogleAuthProvider.credential(
              accessToken: googleSignInAuthentication.accessToken,
              idToken: googleSignInAuthentication.idToken,
            )
            ).then((UserCredential userCredential )async{
              if ( userCredential.user != null){
                final QuerySnapshot result = await FirebaseFirestore.instance.collection('users').where('id', isEqualTo:  userCredential.user?.uid).get();
                final List < DocumentSnapshot > documents = result.docs;

                if (documents.isEmpty) {
                  FirebaseFirestore.instance.collection('users').doc( userCredential.user?.uid).set({ 'nickname':  userCredential.user?.displayName, 'photoUrl':  userCredential.user?.photoURL, 'id':  userCredential.user?.uid });
                }
                Get.find<AuthService>().saveCurrentUser({'nickname':  userCredential.user?.displayName, 'photoUrl':  userCredential.user?.photoURL, 'id':  userCredential.user?.uid});
                Get.offAllNamed(Routes.home);
              }

            });
          }
        }).onError((error, stackTrace) => null);

  }

}
