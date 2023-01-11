import 'dart:io';
import 'dart:convert';
import 'package:flutter_recolectando_innomine/src/environment/environment.dart';
import 'package:flutter_recolectando_innomine/src/models/order.dart';
import 'package:flutter_recolectando_innomine/src/models/response_api.dart';
import 'package:flutter_recolectando_innomine/src/models/user.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class OrdersProvider extends GetConnect {
  String url = Environment.API_URL + 'api/orders';

  User userSession = User.fromJson(GetStorage().read('user') ?? {});

  Future<List<Order>> findByStatus(String status) async {
    Response response = await get('$url/findByOrder/$status', headers: {
      'Content-Type': 'application/json',
      'Authorization': userSession.sessiontoken ?? ''
    }); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    if (response.statusCode == 401) {
      Get.snackbar('Peticion denegada',
          'Tu usuario no tiene permitido leer esta informacion');
      return [];
    }

    List<Order> orders = Order.fromJsonList(response.body);

    return orders;
  }

  Future<List<Order>> findByClientAndStatus(
      String idClient, String status) async {
    Response response =
        await get('$url/findByClientAndStatus/$idClient/$status', headers: {
      'Content-Type': 'application/json',
      'Authorization': userSession.sessiontoken ?? ''
    }); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    if (response.statusCode == 401) {
      Get.snackbar('Peticion denegada',
          'Tu usuario no tiene permitido leer esta informacion');
      return [];
    }

    List<Order> orders = Order.fromJsonList(response.body);

    return orders;
  }

  Future<ResponseApi> create(Order order) async {
    Response response = await post('$url/create', order.toJson(), headers: {
      'Content-Type': 'application/json',
      'Authorization': userSession.sessiontoken ?? ''
    }); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }

  Future<Stream> create1(Order order, File image) async {
    Uri uri = Uri.http(Environment.API_URL_OlD, 'api/orders/create');
    final request = http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = userSession.sessiontoken ?? '';

    request.files.add(http.MultipartFile(
        'image', http.ByteStream(image.openRead().cast()), await image.length(),
        filename: basename(image.path)));

    request.fields['order'] = json.encode(order);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }

  Future<ResponseApi> updateToDispatched(Order order) async {
    Response response =
        await put('$url/updateToDispatched', order.toJson(), headers: {
      'Content-Type': 'application/json',
      'Authorization': userSession.sessiontoken ?? ''
    }); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }

  Future<ResponseApi> updateToOnTheWay(Order order) async {
    Response response =
        await put('$url/updateToOnTheWay', order.toJson(), headers: {
      'Content-Type': 'application/json',
      'Authorization': userSession.sessiontoken ?? ''
    }); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }

  Future<ResponseApi> updateToDelivered(Order order) async {
    Response response =
        await put('$url/updateToDelivered', order.toJson(), headers: {
      'Content-Type': 'application/json',
      'Authorization': userSession.sessiontoken ?? ''
    }); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }

  Future<ResponseApi> updateLatLng(Order order) async {
    Response response =
        await put('$url/updateLatLng', order.toJson(), headers: {
      'Content-Type': 'application/json',
      'Authorization': userSession.sessiontoken ?? ''
    }); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }
}
