import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

// 全局抽屉
class GlobalDrawer extends StatelessWidget {
  const GlobalDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 285,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(0),
            child: Lottie.asset('assets/lottie/drawer.json'),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('首页'),
            selected: Get.currentRoute == '/',
            onTap: () => Get.toNamed('/'),
          ),
          ListTile(
            leading: const Icon(Icons.space_dashboard),
            title: const Text('装备图鉴'),
            selected: Get.currentRoute == '/equipment',
            onTap: () => Get.toNamed('/equipment'),
          ),
          ListTile(
            leading: const Icon(Icons.emoji_emotions),
            title: const Text('英雄图鉴'),
            selected: Get.currentRoute == '/hero',
            onTap: () => Get.toNamed('/hero'),
          ),
          ListTile(
            leading: const Icon(Icons.add_reaction),
            title: const Text('英雄养成'),
            selected: Get.currentRoute == '/hero_foster',
            onTap: () => Get.toNamed('/hero_foster'),
          ),
          ListTile(
            leading: const Icon(Icons.widgets),
            title: const Text('我的装备'),
            selected: Get.currentRoute == '/my_equipment',
            onTap: () => Get.toNamed('/my_equipment'),
          ),
          ListTile(
            leading: const Icon(Icons.auto_awesome),
            title: const Text('召唤模拟'),
            selected: Get.currentRoute == '/summon',
            onTap: () => Get.toNamed('/summon'),
          ),
        ],
      ),
    );
  }
}
