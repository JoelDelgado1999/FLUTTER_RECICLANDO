import 'package:flutter/cupertino.dart';
import 'package:flutter_recolectando_innomine/src/models/response_api.dart';
import 'package:flutter_recolectando_innomine/src/providers/user_providers.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  UserProviders userProviders = UserProviders();

  void goToRegistroPagina() { 
    Get.offNamedUntil('/registro', (route) => false);
  }

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    print('Email ${email}');
    print('Password ${password}');

    if (isValidForm(email, password)) {
      ResponseApi responseApi = await userProviders.login(email, password);
      print('response api:${responseApi.toJson()}');
      if (responseApi.success == true) {
        GetStorage()
            .write('user', responseApi.data); //guardando datos en session
        gotoHomePage();
      } else {
        Get.snackbar('Login fallido', responseApi.message ?? '');
      }
    }
  }

  void gotoHomePage() {
    Get.toNamed('/home');
  }
}

bool isValidForm(String email, String password) {
  if (email.isEmpty) {
    Get.snackbar('Formulario incompleto', 'Debe ingresar el email');
    return false;
  }

  if (!GetUtils.isEmail(email)) {
    Get.snackbar('Formulario invalido', 'El email no es valido');
    return false;
  }

  if (password.isEmpty) {
    Get.snackbar('Formulario incompleto', 'Debe ingresar la contraseña');
    return false;
  }

  return true;
}
