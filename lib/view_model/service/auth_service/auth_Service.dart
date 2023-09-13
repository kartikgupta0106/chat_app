import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthService extends GetxService {
  GetStorage? box;
  Future<AuthService> init() async {
    box = GetStorage();
    return this;
  }

  void saveCurrentUser(Map<String, dynamic> userData) {
    box?.write("userData", userData);
  }

  String get currentUserId => box?.read('userData')['id'] ?? "";
  String get currentUserName => box?.read('userData')['nickname'] ?? "";
}
