import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xbb_start/components/equipment.dart';
import 'package:xbb_start/controllers/hero.dart';

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
