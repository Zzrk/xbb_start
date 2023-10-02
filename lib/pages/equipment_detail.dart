import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xbb_start/components/drawer.dart';
import 'package:xbb_start/utils/equipment.dart';

class EquipmentDetailPage extends StatelessWidget {
  const EquipmentDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final equipment = Get.arguments as Equipment;

    return Scaffold(
        appBar: AppBar(
          title: const Text('装备图鉴'),
        ),
        body: Column(
          children: [
            Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(image: equipment.image),
                Expanded(
                  child: Center(
                    child: Column(
                      children: [
                        Text(equipment.name),
                        const SizedBox(height: 12),
                        Text('品质: ${equipmentQualityMap[equipment.quality]!}'),
                      ],
                    ),
                  ),
                )
              ],
            ),
            if (equipment.description.isNotEmpty)
              Column(
                children: [const Text('装备描述'), Text(equipment.description)],
              ),
            if (equipment.access != null)
              Column(
                children: [
                  const Text('获取途径'),
                  ...List.generate(equipment.access!.length,
                      (index) => Text(equipment.access![index]))
                ],
              )
          ],
        ),
        drawer: const GlobalDrawer());
  }
}
