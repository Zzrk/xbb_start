import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xbb_start/components/drawer.dart';
import 'package:xbb_start/controllers/hero.dart';

import 'package:xbb_start/pages/hero_foster_config/foster_grid_view.dart';
import 'package:xbb_start/pages/hero_foster_config/equipment_grid_view.dart';

// 养成设置
class HeroFosterConfigPage extends StatelessWidget {
  const HeroFosterConfigPage({super.key});

  @override
  Widget build(BuildContext context) {
    final HeroInfoController c = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text('英雄养成设置'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.check),
            tooltip: '确认',
            onPressed: () => Get.toNamed('/hero_foster_summary'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const FosterGridView(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                    onPressed: () {
                      c.computeFoster();
                    },
                    child: const Text('整件装备计算')),
                TextButton(
                    onPressed: () {
                      c.computeFoster();
                      c.computeFragment();
                    },
                    child: const Text('装备碎片计算')),
              ],
            ),
            const EquipmentGridView()
          ],
        ),
      ),
      drawer: const GlobalDrawer(),
    );
  }
}
