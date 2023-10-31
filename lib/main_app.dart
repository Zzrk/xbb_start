import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xbb_start/controllers/equipment.dart';
import 'package:xbb_start/controllers/hero.dart';
import 'package:xbb_start/controllers/my_equipment.dart';
import 'package:xbb_start/controllers/foster_summary.dart';
import 'package:xbb_start/controllers/home.dart';
import 'package:xbb_start/controllers/summon.dart';
import 'package:xbb_start/pages/home/index.dart';
import 'package:xbb_start/pages/equipment.dart';
import 'package:xbb_start/pages/equipment_detail.dart';
import 'package:xbb_start/pages/hero.dart';
import 'package:xbb_start/pages/hero_detail.dart';
import 'package:xbb_start/pages/hero_foster.dart';
import 'package:xbb_start/pages/hero_foster_config/index.dart';
import 'package:xbb_start/pages/hero_foster_summary/index.dart';
import 'package:xbb_start/pages/my_equipment.dart';
import 'package:xbb_start/pages/summon.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 初始化装备和英雄数据
    Get.put(HomeController()).init();
    Get.put(EquipmentController()).initEquipmentList();
    Get.put(HeroInfoController()).initHeroList();
    Get.put(MyEquipmentController()).initMyEquipmentList();
    Get.put(FosterSummaryController());
    Get.put(SummonController());

    return GetMaterialApp(
      title: '小冰冰, 启动!',
      initialRoute: '/',
      // 各级路由
      getPages: [
        // 首页
        GetPage(
          name: '/',
          page: () => const HomePage(),
        ),
        // 装备图鉴
        GetPage(
          name: '/equipment',
          page: () => const EquipmentPage(),
        ),
        // 装备详情
        GetPage(
          name: '/equipment_detail',
          page: () => const EquipmentDetailPage(),
        ),
        // 英雄图鉴
        GetPage(
          name: '/hero',
          page: () => const HeroPage(),
        ),
        // 英雄详情
        GetPage(
          name: '/hero_detail',
          page: () => const HeroDetailPage(),
        ),
        // 英雄养成
        GetPage(
          name: '/hero_foster',
          page: () => const HeroFosterPage(),
        ),
        // 养成设置
        GetPage(
          name: '/hero_foster_config',
          page: () => const HeroFosterConfigPage(),
        ),
        // 养成总结
        GetPage(
          name: '/hero_foster_summary',
          page: () => const HeroFosterSummaryPage(),
        ),
        // 我的装备
        GetPage(
          name: '/my_equipment',
          page: () => const MyEquipmentPage(),
        ),
        // 召唤
        GetPage(
          name: '/summon',
          page: () => const SummonPage(),
        ),
      ],
    );
  }
}
