import 'package:flutter/material.dart';
import 'package:xbb_start/components/equipment.dart';
import 'package:xbb_start/declaration/equipment.dart';

// 装备计算结果
class EquipmentGridView extends StatelessWidget {
  const EquipmentGridView({super.key, required this.computedItemList});

  final List<EquipmentFoster> computedItemList;

  @override
  Widget build(BuildContext context) {
    const itemCount = 4;

    return GridView.builder(
      itemCount: computedItemList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: itemCount),
      itemBuilder: (context, index) {
        final equipment = computedItemList[index].equipment;
        final count = computedItemList[index].count;

        return EquipmentItem(
          equipment: equipment,
          count: count,
          innerPadding: const EdgeInsets.all(4.0),
        );
      },
    );
  }
}
