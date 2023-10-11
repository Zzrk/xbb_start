import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xbb_start/components/drawer.dart';
import 'package:xbb_start/components/equipment.dart';
import 'package:xbb_start/components/hero.dart';
import 'package:xbb_start/controllers/hero.dart';
import 'package:xbb_start/declaration/index.dart';

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

// 选择的养成英雄
class FosterGridView extends StatelessWidget {
  FosterGridView({super.key});
  // 英雄阶段选择列表
  final dropdownItems = heroStageList
      .map((e) => DropdownMenuItem(
            value: e,
            child: Text(e),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    final HeroInfoController c = Get.find();

    const itemCount = 4;
    final itemWidth = MediaQuery.of(context).size.width / itemCount;
    const itemHeight = 140;

    return Obx(() => GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: itemCount,
          childAspectRatio: itemWidth / itemHeight,
          children: c.fosterList.map((fosterInfo) {
            final hero = fosterInfo.hero;

            return Column(
              children: [
                HeroItem(
                  hero: hero,
                  outerPadding: const EdgeInsets.all(0),
                  innerPadding: const EdgeInsets.all(8.0),
                ),
                Expanded(
                  child: DropdownButton(
                    items: dropdownItems,
                    value: fosterInfo.from,
                    onChanged: (value) =>
                        c.modifyFromOrTo(hero, 'from', value!),
                    style: const TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ),
                Expanded(
                  child: DropdownButton(
                    items: dropdownItems,
                    value: fosterInfo.to,
                    onChanged: (value) => c.modifyFromOrTo(hero, 'to', value!),
                    style: const TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ),
              ],
            );
          }).toList(),
        ));
  }
}

// 装备计算结果
class EquipmentGridView extends StatelessWidget {
  const EquipmentGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final HeroInfoController c = Get.find();

    const itemCount = 4;

    return Obx(() => GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: itemCount,
          children: c.computedList.map((element) {
            final equipment = element.equipment;
            final count = element.count;

            return EquipmentItem(
              equipment: equipment,
              count: count,
              innerPadding: const EdgeInsets.all(4.0),
            );
          }).toList(),
        ));
  }
}
