import 'package:flutter/material.dart';
import 'package:flutter_recolectando_innomine/src/pages/login/pagina_login.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

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
    return GetMaterialApp(
      title: 'Reciclando Inomine',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [GetPage(name: '/', page: () => PaginaLogin())],
      theme: ThemeData(
          primaryColor: Colors.amber,
          colorScheme: ColorScheme(
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
