import 'package:flutter/material.dart';
import 'package:flutter_recolectando_innomine/src/pages/home/home_controller.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomeController con = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
        onPressed: () => con.singOut(),
        child: Text(
          'cerrar cesion',
          style: TextStyle(color: Colors.white),
        ),
      )),
    );
  }
}
