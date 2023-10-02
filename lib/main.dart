import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xbb_start/pages/home.dart';
import 'package:xbb_start/pages/equipment.dart';
import 'package:xbb_start/pages/equipment_detail.dart';
import 'package:xbb_start/pages/hero.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '小冰冰, 启动!',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const HomePage()),
        GetPage(name: '/equipment', page: () => const EquipmentPage()),
        GetPage(
            name: '/equipment_detail', page: () => const EquipmentDetailPage()),
        GetPage(name: '/hero', page: () => const HeroPage())
      ],
      // home: HomePage(title: appTitle),
    );
  }
}
