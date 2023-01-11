import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_recolectando_innomine/src/models/address.dart';
import 'package:flutter_recolectando_innomine/src/models/order.dart';
import 'package:flutter_recolectando_innomine/src/models/response_api.dart';
import 'package:flutter_recolectando_innomine/src/models/user.dart';
import 'package:flutter_recolectando_innomine/src/providers/orders_provider.dart';
import 'package:flutter_recolectando_innomine/src/providers/user_providers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class SolicituedesControllers extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController cantidadController = TextEditingController();
  User user = User.fromJson(GetStorage().read('user') ?? {});

  OrdersProvider ordersProvider = OrdersProvider();
  ImagePicker picker = ImagePicker();
  File? imageFile;

  void siguiente(BuildContext context) async {
    String name = nameController.text;
    String cantidad_aprox = cantidadController.text;
    print('nombre ${name}');
    print('cantidad ${cantidad_aprox}');

    if (isValidForm(name, cantidad_aprox)) {
      ProgressDialog progressDialog = ProgressDialog(context: context);
      progressDialog.show(max: 100, msg: 'ENVIANDO...');
      //Map<String, dynamic> adrress = GetStorage().read('address');
      Address a = Address.fromJson(GetStorage().read('address') ?? {});

      Order order = Order(
          nombre_evidencia: name,
          cantidad_aprox: cantidad_aprox,
          idAddress: a.id,
          idClient: user.id
          //timestamp: user.id
          );
      Stream stream = await ordersProvider.create1(order, imageFile!);
      stream.listen((res) {
        //progressDialog.close();
        ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
        if (responseApi.success == true) {
          // DATOS DEL USUARIO EN SESION
          gotoHomePage();
          Get.snackbar('Bienvenidossss', responseApi.message ?? '');
        } else {
          Get.snackbar('registro fallido', responseApi.message ?? '');
        }
      });

      /* Response response = await usersProvider.create(user);
      print('RESPONSE:${response.body}');
      Get.snackbar('listo', 'espera');*/
    }
  }

  /* Map<String, dynamic> adrres = GetStorage().read('address');

     File image = GetStorage().read('EVIDENCIA');
    print('adress ${adrres}');

    {
      Order order = Order(
        nombre_evidencia: name,
        cantidad_aprox: cantidad,
        idClient: user.id,
        idAddress: a.id,
        evidencia: image.toString(),

        //timestamp: user.id
      );

      ResponseApi responseApi = await ordersProvider.create(order);
      Fluttertoast.showToast(
          msg: responseApi.message ?? '', toastLength: Toast.LENGTH_LONG);

      if (responseApi.success == true) {
        order.id = responseApi.data;
        GetStorage().write('order', order.toJson());

        update();

        Get.back();
      }
    }

    /*String name = nameController.text;
    String cantidad_aprox = cantidadController.text;

    print('name ${name}');
    print('cantidad ${cantidad_aprox}');
    if (isValidForm(name, cantidad_aprox)) {
      Order order = Order(
        nombre_evidencia: name,
        cantidad_aprox: cantidad_aprox,
      );
    }

    GetStorage().write('LISTAS_DIRECCIONES_NAME', name);
    GetStorage().write('LISTAS_DIRECCIONES_Cantidad', cantidad_aprox);
    GetStorage().write('EVIDENCIA', imageFile);
    gotoHomePage();*/
  }
*/
  void gotoHomePage() {
    //  Navigator.pushNamed(context, '/client/adress/list',
    //arguments: {'name': 'roberto'});
    Get.offNamedUntil('/home', (route) => false);
  }

  bool isValidForm(
    String name,
    String cantidad,
  ) {
    if (name.isEmpty) {
      Get.snackbar('Formulario no valido',
          'Debes ingresar el nombre de lo que desea recolectar');
      return false;
    }

    if (cantidad.isEmpty) {
      Get.snackbar(
          'Formulario no valido', 'Debes ingresar la cantidad aproximada');
      return false;
    }

    /* if (imageFile == null) {
      Get.snackbar('Formulario no valido', 'Debe seleccionar una imagen');
    }*/
    return true;
  }

  Future selectImage(ImageSource imageSource) async {
    XFile? image = await picker.pickImage(source: imageSource);
    if (image != null) {
      imageFile = File(image.path);
      update();
    }
  }

  void showAlertDialog(BuildContext context) {
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImage(ImageSource.gallery);
        },
        child: Text(
          'GALERIA',
          style: TextStyle(color: Colors.black),
        ));
    Widget cameraButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImage(ImageSource.camera);
        },
        child: Text(
          'CAMARA',
          style: TextStyle(color: Colors.black),
        ));

    AlertDialog alertDialog = AlertDialog(
      title: Text('Selecciona una opcion'),
      actions: [galleryButton, cameraButton],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
}
