import 'package:flutter_recolectando_innomine/src/models/order.dart';
import 'package:flutter_recolectando_innomine/src/models/response_api.dart';
import 'package:flutter_recolectando_innomine/src/models/user.dart';
import 'package:flutter_recolectando_innomine/src/providers/orders_provider.dart';
import 'package:flutter_recolectando_innomine/src/providers/user_providers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class RestaurantOrdersDetailController extends GetxController {
  Order order = Order.fromJson(Get.arguments['order']);

  var total = 0.0.obs;
  var idDelivery = ''.obs;

  UserProviders usersProvider = UserProviders();
  OrdersProvider ordersProvider = OrdersProvider();
  List<User> users = <User>[].obs;
/*
  RestaurantOrdersDetailController() {
    print('Order: ${order.toJson()}');
    getDeliveryMen();
    getTotal();
  } */

  void updateOrder() async {
    if (idDelivery.value != '') {
      // SI SELECCIONO EL DELIVERY
      order.idDelivery = idDelivery.value;
      ResponseApi responseApi = await ordersProvider.updateToDispatched(order);
      Fluttertoast.showToast(
          msg: responseApi.message ?? '', toastLength: Toast.LENGTH_LONG);
      if (responseApi.success == true) {
        Get.offNamedUntil('/restaurant/home', (route) => false);
      }
    } else {
      Get.snackbar('Peticion denegada', 'Debes asignar el repartidor');
    }
  }

  /* void getDeliveryMen() async {
    var result = await usersProvider.findDeliveryMen();
    users.clear();
    users.addAll(result);
  }

  void getTotal() {
    total.value = 0.0;
    order.products!.forEach((product) {
      total.value = total.value + (product.quantity! * product.price!);
    });
  }*/

}
