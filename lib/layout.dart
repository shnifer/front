import 'package:flutter/material.dart';
import 'package:front/pages/options/options_page.dart';
import 'package:front/pages/rooms/rooms_page.dart';
import 'package:front/pages/users/users_page.dart';
import 'package:front/side_menu.dart';
import 'package:get/get.dart';

enum MenuPage {options, users, rooms}

class MenuController extends GetxController{
  var curPage = MenuPage.options.obs;
}

class Layout extends StatelessWidget{
  const Layout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MenuController c = Get.find();
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.black12,
            child: const SideMenu(),
          ),
        ),
        Expanded(
          flex:6,
          child: Obx((){
              switch (c.curPage.value) {
                case MenuPage.options:
                  return const OptionsPage();
                case MenuPage.users:
                  return const UsersPage();
                case MenuPage.rooms:
                  return const RoomsPage();
              }
            }),
        ),
      ],
    );
  }
}