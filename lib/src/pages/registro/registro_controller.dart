import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recolectando_innomine/src/models/user.dart';
import 'package:flutter_recolectando_innomine/src/providers/user_providers.dart';
import 'package:get/get.dart';

class RegistroController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();

  UserProviders userProviders = UserProviders();

  void Registro() async {
    String email = emailController.text.trim();
    String name = nameController.text.trim();
    String lastname = lastnameController.text.trim();
    String phone = phoneController.text.trim();
    String image = imageController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmpasswordController.text.trim();

    print('Email ${email}');
    print('Password ${password}');

    if (isValidForm(email, name, lastname, phone, password, confirmPassword)) {
      User user = User(
        email: email,
        name: name,
        lastname: lastname,
        phone: phone,
        image: image,
        password: password,
      );
      Response response = await userProviders.create(user);
      print('RESPONSE${response.body}');

      Get.snackbar(
          'Formulario valido', 'Estas listo para enviar la peticion Http');
    }
  }

  bool isValidForm(String email, String name, String lastname, String phone,
      String password, String confirmPassword) {
    if (email.isEmpty) {
      Get.snackbar('Formulario incompleto', 'Debe ingresar el email');
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar('Formulario invalido', 'El email no es valido');
      return false;
    }
    if (name.isEmpty) {
      Get.snackbar('Formulario incompleto', 'Debe ingresar el nombre');
      return false;
    }
    if (lastname.isEmpty) {
      Get.snackbar('Formulario incompleto', 'Debe ingresar el apellido');
      return false;
    }
    if (phone.isEmpty) {
      Get.snackbar(
          'Formulario incompleto', 'Debe ingresar su numero de contacto');
      return false;
    }
    if (password.isEmpty) {
      Get.snackbar('Formulario incompleto', 'Debe ingresar la contraseña');
      return false;
    }
    if (confirmPassword.isEmpty) {
      Get.snackbar('Formulario incompleto', 'comfirmar  la contraseña');
      return false;
    }
    if (password != confirmPassword) {
      Get.snackbar('Formulario incompleto', 'las contraseñas no coinciden');
      return false;
    }
    return true;
  }

  void showAlertDialog(BuildContext context) {
    Widget galleryButton =
        ElevatedButton(onPressed: () {}, child: Text('galeria'));
    Widget camaraButton =
        ElevatedButton(onPressed: () {}, child: Text('camara'));
    AlertDialog alertDialog = AlertDialog(
      title: Text('seleccione una opcion'),
      actions: [galleryButton, camaraButton],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
}
