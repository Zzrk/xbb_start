import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xbb_start/controllers/equipment.dart';
import 'package:xbb_start/controllers/hero.dart';
import 'package:xbb_start/pages/home.dart';
import 'package:xbb_start/pages/equipment.dart';
import 'package:xbb_start/pages/equipment_detail.dart';
import 'package:xbb_start/pages/hero.dart';
import 'package:xbb_start/pages/hero_detail.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final EquipmentController c1 = Get.put(EquipmentController());
  final HeroInfoController c2 = Get.put(HeroInfoController());

  @override
  Widget build(BuildContext context) {
    // 初始化装备和英雄数据
    c1.initEquipmentList();
    c2.initHeroList();

    return GetMaterialApp(
      title: '小冰冰, 启动!',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const HomePage()),
        GetPage(name: '/equipment', page: () => const EquipmentPage()),
        GetPage(
            name: '/equipment_detail', page: () => const EquipmentDetailPage()),
        GetPage(name: '/hero', page: () => const HeroPage()),
        GetPage(name: '/hero_detail', page: () => const HeroDetailPage()),
      ],
    );
  }
}
