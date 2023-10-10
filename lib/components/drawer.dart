import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 全局抽屉
class GlobalDrawer extends StatelessWidget {
  const GlobalDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text('小冰冰, 启动!', style: TextStyle(color: Colors.white)),
          ),
          ListTile(
            title: const Text('首页'),
            selected: Get.currentRoute == '/',
            onTap: () => Get.toNamed('/'),
          ),
          ListTile(
            title: const Text('装备图鉴'),
            selected: Get.currentRoute == '/equipment',
            onTap: () => Get.toNamed('/equipment'),
          ),
          ListTile(
            title: const Text('英雄图鉴'),
            selected: Get.currentRoute == '/hero',
            onTap: () => Get.toNamed('/hero'),
          ),
          ListTile(
            title: const Text('英雄养成'),
            selected: Get.currentRoute == '/hero_foster',
            onTap: () => Get.toNamed('/hero_foster'),
          ),
          ListTile(
            title: const Text('我的装备'),
            selected: Get.currentRoute == '/my_equipment',
            onTap: () => Get.toNamed('/my_equipment'),
          ),
        ],
      ),
    );
  }
}
