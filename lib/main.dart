import 'package:flutter/material.dart';
import 'package:flutter_recolectando_innomine/src/models/user.dart';
import 'package:flutter_recolectando_innomine/src/pages/client/adrres/create/client_create_adress_page.dart';

import 'package:flutter_recolectando_innomine/src/pages/client/adrres/list/client_adress_list_page.dart';
import 'package:flutter_recolectando_innomine/src/pages/client/adrres/map/client_address_map_page.dart';
import 'package:flutter_recolectando_innomine/src/pages/client/orders/detail/client_orders_detail_page.dart';
import 'package:flutter_recolectando_innomine/src/pages/client/orders/list/client_orders_list_page.dart';
import 'package:flutter_recolectando_innomine/src/pages/client/products/list/client_products_list_page.dart';

import 'package:flutter_recolectando_innomine/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:flutter_recolectando_innomine/src/pages/client/profile/update/client_profile_update_page.dart';
import 'package:flutter_recolectando_innomine/src/pages/client/solicitudes/solicitudespage.dart';
import 'package:flutter_recolectando_innomine/src/pages/home/home_page.dart';
import 'package:flutter_recolectando_innomine/src/pages/login/pagina_login.dart';
import 'package:flutter_recolectando_innomine/src/pages/registro/registro_pagina.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';

User userSession = User.fromJson(GetStorage().read('user') ?? {});
void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('usuario id:${userSession.id}');

    return GetMaterialApp(
      title: 'Reciclando Inomine',
      debugShowCheckedModeBanner: false,
      initialRoute: userSession.id != null ? '/' : '/',
      getPages: [
        GetPage(name: '/', page: () => PaginaLogin()),
        GetPage(name: '/registro', page: () => RegistroPagina()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(
            name: '/client/adress/create',
            page: () => ClientCreateAddressPage()),
        GetPage(
            name: '/client/adress/list', page: () => clientAdressListPage()),
        GetPage(
            name: '/client/profile/info', page: () => ClientProfileInfoPage()),
        GetPage(
            name: '/client/solicitudes/solicitudesPage',
            page: () => SolicitudesPage()),
        GetPage(
            name: '/client/Orders/ListaOrdenes',
            page: () => ClientOrdersListPage()),
        GetPage(
            name: '/client/Orders/Mapa', page: () => ClientAddressMapPage()),
        GetPage(
            name: '/client/profile/update',
            page: () => ClientProfileUpdatePage()),
        GetPage(
            name: '/client/orders/detail',
            page: () => ClientOrdersDetailPage()),
        GetPage(
            name: '/client/premios/premiospage',
            page: () => ClientProductsListPage()),
      ],
      theme: ThemeData(
          primaryColor: Colors.amber,
          colorScheme: const ColorScheme(
              primary: Colors.green,
              secondary: Colors.amberAccent,
              brightness: Brightness.light,
              onBackground: Colors.grey,
              onPrimary: Colors.grey,
              surface: Colors.grey,
              onSurface: Colors.grey,
              error: Colors.grey,
              onError: Colors.grey,
              onSecondary: Colors.grey,
              background: Colors.grey)),
      navigatorKey: Get.key,
    );
  }
}
