import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xbb_start/utils/equipment.dart';

class EquipmentItem extends StatelessWidget {
  const EquipmentItem({
    super.key,
    required this.equipment,
    this.imageSize = 32,
    this.fontSize = 12,
    this.outerPadding = const EdgeInsets.only(top: 8.0),
    this.innerPadding = const EdgeInsets.all(12.0),
    this.count,
  });

  final Equipment equipment;
  final double imageSize;
  final double fontSize;
  final EdgeInsets outerPadding;
  final EdgeInsets innerPadding;
  final int? count;

  @override
  Widget build(BuildContext context) {
    final equipmentName = equipment.name;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        // 跳转到装备详情页
        Get.toNamed(
          '/equipment_detail?name=$equipmentName',
          arguments: equipment,
        );
      },
      child: Padding(
        padding: outerPadding,
        child: Column(
          children: [
            Padding(
              padding: innerPadding,
              child: Image.asset(
                'assets/equipment/${equipmentName.replaceAll('(碎片)', '')}.jpg',
                width: imageSize,
                height: imageSize,
              ),
            ),
            Text(
              equipmentName,
              style: TextStyle(fontSize: fontSize),
            ),
            if (count != null) Text('x$count')
          ],
        ),
      ),
    );
  }
}
