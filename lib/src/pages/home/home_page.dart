import 'package:flutter/material.dart';
import 'package:flutter_recolectando_innomine/src/pages/client/adrres/map/client_address_map_page.dart';

import 'package:flutter_recolectando_innomine/src/pages/client/orders/homeSolicitudes.dart';
import 'package:flutter_recolectando_innomine/src/pages/client/orders/list/client_orders_list_page.dart';

import 'package:flutter_recolectando_innomine/src/pages/client/products/list/client_products_list_page.dart';
import 'package:flutter_recolectando_innomine/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:flutter_recolectando_innomine/src/pages/home/home_controller.dart';
import 'package:flutter_recolectando_innomine/src/pages/login/pagina_login.dart';
import 'package:flutter_recolectando_innomine/src/pages/registro/registro_pagina.dart';
import 'package:flutter_recolectando_innomine/src/utils/custom_animated_bottom_bar%20(1).dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomeController con = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: _bottonBar(),
        body: Obx(() => IndexedStack(
                  index: con.indexTab.value,
                  children: [
                    ClientOrdersListPage(),
                    //HomeSolicitudes(),

                    ClientProductsListPage(),
                    ClientProfileInfoPage()
                  ],
                ) /*Center(
          child: ElevatedButton(
        onPressed: () => con.singOut(),
        child: Text(
          'cerrar cesion',
          style: TextStyle(color: Colors.white),
        ),
      ))*/
            ));
  }

  Widget _bottonBar() {
    return Obx(() => CustomAnimatedBottomBar(
          containerHeight: 70,
          backgroundColor: Colors.green,
          showElevation: true,
          itemCornerRadius: 24,
          curve: Curves.easeIn,
          selectedIndex: con.indexTab.value,
          onItemSelected: (index) => con.changeTab(index),
          items: [
            BottomNavyBarItem(
              icon: Icon(Icons.list_alt_outlined),
              title: Text('SOLICITUDES'),
              activeColor: Colors.white,
              inactiveColor: Colors.amber,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.card_giftcard_outlined),
              title: Text('PREMIOS'),
              activeColor: Colors.white,
              inactiveColor: Colors.amber,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.person),
              title: Text('MI PERFIL'),
              activeColor: Colors.white,
              inactiveColor: Colors.amber,
            ),
          ],
        ));
  }
}
