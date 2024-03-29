import 'package:flutter/material.dart';
import 'package:front/connectors/http_controller.dart';
import 'package:front/layout.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

   @override
  Widget build(BuildContext context) {
    Get.put(HttpConnectController()..initLocalSettings());
    Get.put(MenuController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nemesis admin front',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Админка Немезиды")),
        ),
        body: const Layout(),
      ),
    );
  }
}