import 'package:flutter_recolectando_innomine/src/models/order.dart';
import 'package:flutter_recolectando_innomine/src/models/user.dart';
import 'package:flutter_recolectando_innomine/src/providers/orders_provider.dart';
import 'package:flutter_recolectando_innomine/src/providers/user_providers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ClientOrdersDetailController extends GetxController {
  Order order = Order.fromJson(Get.arguments['order']);

  var total = 0.0.obs;
  var idDelivery = ''.obs;

  UserProviders usersProvider = UserProviders();
  OrdersProvider ordersProvider = OrdersProvider();
  List<User> users = <User>[].obs;

  ClientOrdersDetailController() {
    print('Order: ${order.toJson()}');
    //getTotal();
  }
  void goToPremios() {
    Get.toNamed(
      '/client/premios/premiospage',
    );
  }

  void goToOrderMap() {
    Get.toNamed('/client/orders/map', arguments: {'order': order.toJson()});
  }

  /* void getTotal() {
    total.value = 0.0;
    order.products!.forEach((product) {
      total.value = total.value + (product.quantity! * product.price!);
    });
  }*/

}
