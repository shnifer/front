import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:front/layout.dart';

class SideMenu extends StatelessWidget{
  const SideMenu({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        SideMenuItem(text: "Options", page: MenuPage.options),
        SideMenuItem(text: "Users", page: MenuPage.users),
        SideMenuItem(text: "Rooms", page: MenuPage.rooms),
      ],
    );
  }
}

class SideMenuItem extends StatelessWidget {
  final String text;
  final MenuPage page;
  const SideMenuItem({Key? key, required this.text, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MenuController c = Get.find();
    return Padding(
      padding: const EdgeInsets.all(30),
      child: ElevatedButton(
        child: SizedBox(
          height: 60,
          child: Center(
            child: Text(text),
          ),
        ),
        onPressed: (){
          c.curPage.value = page;
        },
      ),
    );
  }
}