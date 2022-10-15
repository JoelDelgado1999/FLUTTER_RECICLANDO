import 'package:flutter/material.dart';
import 'package:flutter_recolectando_innomine/src/models/user.dart';
import 'package:flutter_recolectando_innomine/src/pages/home/home_page.dart';
import 'package:flutter_recolectando_innomine/src/pages/login/pagina_login.dart';
import 'package:flutter_recolectando_innomine/src/pages/registro/registro_pagina.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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
      initialRoute: userSession.id != null ? '/home' : '/',
      getPages: [
        GetPage(name: '/', page: () => PaginaLogin()),
        GetPage(name: '/registro', page: () => RegistroPagina()),
        GetPage(name: '/home', page: () => HomePage())
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
