import 'package:flutter_recolectando_innomine/src/environment/environment.dart';
import 'package:flutter_recolectando_innomine/src/models/user.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_recolectando_innomine/src/models/premios.dart';

class PremiosProvider extends GetConnect {
  String url = Environment.API_URL + 'api/premios';
  User userSession = User.fromJson(GetStorage().read('user') ?? {});

  Future<List<Premios>> getAllPremios() async {
    Response response = await get('$url/getAll/', headers: {
      'Content-Type': 'application/json',
    }); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    if (response.statusCode == 401) {
      Get.snackbar('Peticion denegada',
          'Tu usuario no tiene permitido leer esta informacion');
      return [];
    }

    List<Premios> premios = Premios.fromJsonList(response.body);

    return premios;
  }
}
