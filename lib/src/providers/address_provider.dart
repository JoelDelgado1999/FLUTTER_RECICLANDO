import 'package:flutter_recolectando_innomine/src/environment/environment.dart';
import 'package:flutter_recolectando_innomine/src/models/response_api.dart';
import 'package:flutter_recolectando_innomine/src/models/user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_recolectando_innomine/src/models/address.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AddressProvider extends GetConnect {
  String url = Environment.API_URL + 'api/address';

  User userSession = User.fromJson(
    GetStorage().read('user') ?? {},
  );

  Future<List<Address>> findByUser(String idUser) async {
    //print('users ${userSession.sessiontoken}');
    Response response = await get('$url/findByUser/$idUser', headers: {
      'Content-Type': 'application/json',
      'Authorization': userSession.sessiontoken ?? '',
    }); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    if (response.statusCode == 401) {
      Get.snackbar('Peticion denegada',
          'Tu usuario no tiene permitido leer esta informacion');

      return [];
    }
    print('errResponse  ${response.body}');
    List<Address> address = Address.fromJsonList(response.body);

    return address;
  }

  Future<ResponseApi> deleteAdress(String? id_address) async {
    //print('users ${userSession.sessiontoken}');

    Response response = await delete('$url/delete/$id_address', headers: {
      'Content-Type': 'application/json',
      'Authorization': userSession.sessiontoken ?? '',
    }); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    if (response.statusCode == 401) {
      Get.snackbar('Peticion denegada',
          'Tu usuario no tiene permitido leer esta informacion');
    }
    print('errResponse  ${response.body}');
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;

    /*List<Address> address = Address.fromJsonList(response.body);

    return address;*/
  }

  Future<ResponseApi> create(Address address) async {
    Response response = await post('$url/create', address.toJson(), headers: {
      'Content-Type': 'application/json',
      'Authorization': userSession.sessiontoken ?? ''
    }); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }
}
