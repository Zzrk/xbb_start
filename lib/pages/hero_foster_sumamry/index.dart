import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xbb_start/components/drawer.dart';
import 'package:xbb_start/controllers/hero.dart';

import 'package:xbb_start/pages/hero_foster_sumamry/foster_grid_view.dart';
import 'package:xbb_start/pages/hero_foster_sumamry/equipment_grid_view.dart';

// 养成总结
class HeroFosterSummaryPage extends StatelessWidget {
  const HeroFosterSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final HeroInfoController c = Get.find();

    return Scaffold(
      appBar: AppBar(title: const Text('英雄养成总结')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FosterGridView(),
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
