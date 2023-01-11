import 'dart:convert';
import 'dart:io';
import 'package:flutter_recolectando_innomine/main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path/path.dart';
import 'package:flutter_recolectando_innomine/src/environment/environment.dart';
import 'package:flutter_recolectando_innomine/src/models/response_api.dart';
import 'package:flutter_recolectando_innomine/src/models/user.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UserProviders extends GetConnect {
  String url = Environment.API_URL + 'api/users';

  User userSession = User.fromJson(GetStorage().read('user') ?? {});

  Future<Response> create(User user) async {
    Response response = await post('$url/create', user.toJson(), headers: {
      'Content-Type': 'application/json'
    }); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    return response;
  }

  // SIN IMAGEN
  Future<ResponseApi> update(User user) async {
    Response response =
        await put('$url/updateWithoutImage', user.toJson(), headers: {
      'Content-Type': 'application/json',
      'Authorization': userSession.sessiontoken ?? ''
    }); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    if (response.body == null) {
      Get.snackbar('Error', 'No se pudo actualizar la informacion');
      return ResponseApi();
    }

    if (response.statusCode == 401) {
      Get.snackbar('Error', 'No estas autorizado para realizar esta peticion');
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }

  Future<ResponseApi> updateNotificationToken(String id, String token) async {
    Response response = await put('$url/updateNotificationToken', {
      'id': id,
      'token': token
    }, headers: {
      'Content-Type': 'application/json',
      'Authorization': userSession.sessiontoken ?? ''
    }); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    if (response.body == null) {
      Get.snackbar('Error', 'No se pudo actualizar la informacion');
      return ResponseApi();
    }

    if (response.statusCode == 401) {
      Get.snackbar('Error', 'No estas autorizado para realizar esta peticion');
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }

  Future<Stream> createWithImage(User user, File image) async {
    Uri uri = Uri.http(Environment.API_URL_OlD, '/api/users/createWithImage');
    final request = http.MultipartRequest('POST', uri);
    request.files.add(http.MultipartFile(
        'image', http.ByteStream(image.openRead().cast()), await image.length(),
        filename: basename(image.path)));
    request.fields['user'] = json.encode(user);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }

  Future<Stream> updateWithImage(User user, File image) async {
    Uri uri = Uri.http(Environment.API_URL_OlD, '/api/users/update');
    final request = http.MultipartRequest('PUT', uri);
    request.headers['Authorization'] = userSession.sessiontoken ?? '';
    request.files.add(http.MultipartFile(
        'image', http.ByteStream(image.openRead().cast()), await image.length(),
        filename: basename(image.path)));
    request.fields['user'] = json.encode(user);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }

  /*
  * GET X
   */
  Future<ResponseApi> createUserWithImageGetX(User user, File image) async {
    FormData form = FormData({
      'image': MultipartFile(image, filename: basename(image.path)),
      'user': json.encode(user)
    });
    Response response = await post('$url/createWithImage', form);

    if (response.body == null) {
      Get.snackbar('Error en la peticion', 'No se pudo crear el usuario');
      return ResponseApi();
    }
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }

  Future<ResponseApi> login(String email, String password) async {
    Response response = await post('$url/login', {
      'email': email,
      'password': password
    }, headers: {
      'Content-Type': 'application/json'
    }); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    if (response.body == null) {
      Get.snackbar('Error', 'No se pudo ejecutar la peticion');
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }
} 




/*{
  String url = Environment.API_URL + 'api/users';

  Future<Response> create(User user) async {
    Response response = await post('$url/create', user.toJson(), headers: {
      'Content-Type': 'application/json'
    }); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    return response;
  }

  Future<Stream> createWithImage(User user, File image) async {
    Uri uri = Uri.http(Environment.API_URL_OlD, '/api/users/createWithImage');
    final request = http.MultipartRequest('POST', uri);
    request.files.add(http.MultipartFile(
        'image', http.ByteStream(image.openRead().cast()), await image.length(),
        filename: basename(image.path)));
    request.fields['user'] = json.encode(user);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }

  Future<ResponseApi> update(User user) async {
    Response response =
        await put('$url/updateWithoutImage', user.toJson(), headers: {
      'Content-Type': 'application/json',
      'Authorization': userSession.sessiontoken ?? ''
    }); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    if (response.body == null) {
      Get.snackbar('Error', 'No se pudo actualizar la informacion');
      return ResponseApi();
    }

    if (response.statusCode == 401) {
      Get.snackbar('Error', 'No estas autorizado para realizar esta peticion');
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }

  Future<Stream> updateWithImage(User user, File image) async {
    Uri uri = Uri.http(Environment.API_URL_OlD, '/api/users/update');
    final request = http.MultipartRequest('PUT', uri);
    request.headers['Authorization'] = userSession.sessiontoken ?? '';
    request.files.add(http.MultipartFile(
        'image', http.ByteStream(image.openRead().cast()), await image.length(),
        filename: basename(image.path)));
    request.fields['user'] = json.encode(user);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }

  Future<ResponseApi> login(String email, String password) async {
    Response response = await post('$url/login', {
      'email': email,
      'password': password
    }, headers: {
      'Content-Type': 'application/json'
    }); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    if (response.body == null) {
      Get.snackbar(
          'Error', 'Revisa tu conexion de internet y vuelve a intentarlo');
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }
}
*/