import 'dart:convert';
import 'dart:io';

import 'package:flutter_recolectando_innomine/src/models/user.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recolectando_innomine/src/providers/user_providers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

import '../../../models/response_api.dart';

class ClientOrderCreateController extends GetxController {
  User user = User.fromJson(GetStorage().read('user') ?? {});
  HomeController() {
    print('usuario de sesion  :${user.toJson()}');
  }

  void singOut() {
    GetStorage().remove('user');
    Get.offNamedUntil('/', (route) => false);
  }

  void goToAdressList() {
    Get.toNamed('client/adress/list');
  }
}
