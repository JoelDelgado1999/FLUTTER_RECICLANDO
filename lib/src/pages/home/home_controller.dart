import 'package:flutter_recolectando_innomine/src/models/user.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  User user = User.fromJson(GetStorage().read('user') ?? {});
  HomeController() {
    print('usuario de sesion  :${user.toJson()}');
  }
  void singOut() {
    GetStorage().remove('user');
    Get.offNamedUntil('/', (route) => false);
  }
}
