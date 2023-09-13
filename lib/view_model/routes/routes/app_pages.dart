import 'package:chatting_app/view/screens/root_view/chat_Screen.dart';
import 'package:chatting_app/view/screens/root_view/home_Screen.dart';
import 'package:get/get.dart';

import '../../../view/screens/auth_view/login_Screen.dart';

part 'app_routes.dart';

class AppPages {
  static final routes = <GetPage>[

    // GetPage(name: Routes.splash, page: () => const Splash(),),
    GetPage(name: Routes.home, page: () => const Home()),
    GetPage(name: Routes.login, page: () => const LoginScreen()),
    GetPage(name: Routes.chat, page: () => const ChatScreen()),
  ];
}

// class RootControllerBinding implements Bindings{
//   @override
//   void dependencies() {
//     Get.lazyPut(() => RootController());
//   }
//
// }