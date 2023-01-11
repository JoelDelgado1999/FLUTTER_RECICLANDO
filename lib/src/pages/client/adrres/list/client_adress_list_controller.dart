import 'dart:io';

import 'package:flutter_recolectando_innomine/src/models/address.dart';
import 'package:flutter_recolectando_innomine/src/models/response_api.dart';
import 'package:flutter_recolectando_innomine/src/models/user.dart';
import 'package:flutter_recolectando_innomine/src/pages/client/adrres/list/client_adress_list_page.dart';
import 'package:flutter_recolectando_innomine/src/pages/client/solicitudes/solicitudespage.dart';
import 'package:flutter_recolectando_innomine/src/widgets/evidencia_imagenes.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_recolectando_innomine/src/models/order.dart';
import 'package:flutter_recolectando_innomine/src/providers/address_provider.dart';
import 'package:flutter_recolectando_innomine/src/providers/orders_provider.dart';
import 'package:flutter_recolectando_innomine/src/pages/client/solicitudes/solicitudesController.dart';
import 'package:flutter_recolectando_innomine/src/models/order.dart';

class ClientAdressListController extends GetxController {
  List<Address> address = <Address>[].obs;

  AddressProvider addressProvider = AddressProvider();
  OrdersProvider ordersProvider = OrdersProvider();
  User user = User.fromJson(GetStorage().read('user') ?? {});
  File? imageFile;

  int radioValue = 0;

  ClientAddressListController() {
    print('LA DIRECCION DE SESION ${GetStorage().read('address')}');
  }

  void SolicitudesPage() {
    Get.offNamedUntil('/home', (route) => false);
  }

  Future<List<Address>> getAddress() async {
    address = await addressProvider.findByUser(user.id ?? '');
    print('Address ${address}');
    Address a = Address.fromJson(GetStorage().read('address') ??
        {}); // DIRECCION SELECCIONADA POR EL USUARIO
    int index = address.indexWhere((ad) => ad.id == a.id);

    if (index != -1) {
      // LA DIRECCION DE SESION COINCIDE CON UN DATOS DE LA LISTA DE DIRECCIONES
      radioValue = index;
    }

    return address;
  }

  void createOrder() async {
    gotoevidencia();
    Address a = Address.fromJson(GetStorage().read('address') ?? {});
    /*String name = GetStorage().read('LISTAS_DIRECCIONES_NAME');
    String cantidad = GetStorage().read('LISTAS_DIRECCIONES_Cantidad');
    //String timeStap = GetStorage().read('LISTAS_DIRECCIONES_Cantidad');
    Map<String, dynamic> adrres = GetStorage().read('address');
    Address a = Address.fromJson(GetStorage().read('address') ?? {});
    File image = GetStorage().read('EVIDENCIA');
    print('Name ${name}');
    print('cantidad ${cantidad}');
    print('adresss ${adrres}');

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
    }*/
  }

  void gotoevidencia() {
    Get.toNamed('/client/solicitudes/solicitudesPage');
  }

  void deleteItem(Address addresss) async {
    address.remove(addresss);
    address.clear();
    GetStorage().write('sss', addresss);

    ResponseApi responseApi = await addressProvider.deleteAdress(addresss.id);
    if (responseApi.success == true) {
      Get.snackbar('LISTO', responseApi.message ?? '');
    }
  }

  void handleRadioValueChange(int? value) {
    radioValue = value!;
    print('VALOR SELECCIONADO ${value}');
    GetStorage().write('address', address[value].toJson());
    update();
  }

  void goToAddressCreate() {
    Get.toNamed('/client/adress/create');
  }

  void goTohome() {
    Get.toNamed('/client/Orders/ListaOrdenes');
  }
}
