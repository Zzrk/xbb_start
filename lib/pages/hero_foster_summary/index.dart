import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xbb_start/components/drawer.dart';
import 'package:xbb_start/controllers/foster_summary.dart';
import 'package:xbb_start/pages/hero_foster_summary/equipment_grid_view.dart';

// 养成总结
class HeroFosterSummaryPage extends StatelessWidget {
  const HeroFosterSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FosterSummaryController c = Get.find();

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('英雄养成总结'),
          bottom: const TabBar(
            tabs: [
              Tab(text: '装备计算'),
              Tab(text: '碎片计算'),
              Tab(text: '装备需求'),
              Tab(text: '碎片需求'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            EquipmentGridView(computedItemList: c.computedItemList),
            EquipmentGridView(computedItemList: c.computedFragmentList),
            EquipmentGridView(computedItemList: c.neededItemList),
            EquipmentGridView(computedItemList: c.neededFragmentList),
          ],
        ),
        drawer: const GlobalDrawer(),
      ),
    );
  }
}
