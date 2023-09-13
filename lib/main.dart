import 'package:chatting_app/view/screens/auth_view/login_Screen.dart';
import 'package:chatting_app/view_model/routes/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'view_model/service/auth_service/auth_Service.dart';

void main() async{
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Get.putAsync(() => AuthService().init());
  runApp(const MyApp());
}




class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
     initialRoute: Routes.login,
     // initialRoute: GetStorage().hasData('userData') ? Routes.home : Routes.login,
      getPages: AppPages.routes,
    );
  }
}
