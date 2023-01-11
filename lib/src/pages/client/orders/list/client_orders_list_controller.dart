import 'package:flutter_recolectando_innomine/src/models/address.dart';
import 'package:flutter_recolectando_innomine/src/models/order.dart';
import 'package:flutter_recolectando_innomine/src/models/user.dart';
import 'package:flutter_recolectando_innomine/src/providers/address_provider.dart';
import 'package:flutter_recolectando_innomine/src/providers/orders_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class ClientOrdersListController extends GetxController {
  OrdersProvider ordersProvider = OrdersProvider();
  List<String> status = <String>['EN ESPERA', 'EN CAMINO', 'ENTREGADO'].obs;

  User user = User.fromJson(GetStorage().read('user') ?? {});

  Future<List<Order>> getOrders(String status) async {
    return await ordersProvider.findByClientAndStatus(user.id ?? '0', status);
  }

  void goToOrderDetail(Order order) {
    Get.toNamed('/client/orders/detail', arguments: {'order': order.toJson()});
  }
}
/*class ClientOrdersListController extends GetxController {
  OrdersProvider ordersProvider = OrdersProvider();
  List<String> status =
      <String>['EN ESPERA', 'ESPERANDO INICIO', 'EN CAMINO', 'FINALIZADO'].obs;

  User user = User.fromJson(GetStorage().read('user') ?? {});

  Future<List<Order>> getOrders(String status) async {
    return await ordersProvider.findByStatus(
      user.id ?? '0',
    );
  }

  getFormatedDate(Order order) {
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(order.timestamp.toString());
    var outputFormat = DateFormat('dd/MM/yyyy');
    return outputFormat.format(inputDate);
  }

  void goToOrderDetail(Order order) {
    Get.toNamed('/client/orders/detail', arguments: {'order': order.toJson()});
  }
}
*/