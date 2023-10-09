import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xbb_start/components/drawer.dart';
import 'package:xbb_start/components/equipment.dart';
import 'package:xbb_start/controllers/equipment.dart';
import 'package:xbb_start/utils/equipment.dart';

// 装备详情
class EquipmentDetailPage extends StatelessWidget {
  const EquipmentDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final EquipmentController c = Get.find();
    final equipment = Get.arguments as Equipment;

    return Scaffold(
        appBar: AppBar(title: const Text('装备图鉴')),
        body: Column(
          children: [
            Row(
              children: [
                Image.asset(
                    'assets/equipment/${equipment.name.replaceAll('(碎片)', '')}.jpg'),
                Expanded(
                  child: Center(
                    child: Column(
                      children: [
                        Text(equipment.name),
                        const SizedBox(height: 12),
                        Text('品质: ${equipment.quality}'),
                        if (equipment.level != null) const SizedBox(height: 12),
                        if (equipment.level != null)
                          Text('需求英雄等级: ${equipment.level}'),
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 12),
            if (equipment.description.isNotEmpty)
              Card(
                child: Column(children: [
                  const ListTile(title: Text('装备描述')),
                  const Divider(),
                  Text(equipment.description),
                  const SizedBox(height: 8)
                ]),
              ),
            if (equipment.access != null && equipment.access!.isNotEmpty)
              Card(
                child: Column(children: [
                  const ListTile(title: Text('获取途径')),
                  const Divider(),
                  ...List.generate(equipment.access!.length,
                      (index) => Text(equipment.access![index])),
                  const SizedBox(height: 8)
                ]),
              ),
            if (equipment.synthesis != null && equipment.synthesis!.isNotEmpty)
              Card(
                child: Column(children: [
                  const ListTile(title: Text('装备合成')),
                  const Divider(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...List.generate(equipment.synthesis!.length, (index) {
                        final synthesis = equipment.synthesis![index];
                        final type =
                            synthesis.name.contains('碎片') ? 'fragment' : 'item';
                        final e = c.equipmentData[type]!.firstWhere(
                            (element) => element.name == synthesis.name);

                        return EquipmentItem(
                          equipment: e,
                          imageSize: 64,
                          fontSize: 14,
                          outerPadding: const EdgeInsets.all(8.0),
                          innerPadding: const EdgeInsets.all(0),
                          count: synthesis.count,
                        );
                      }),
                    ],
                  ),
                  const SizedBox(height: 8)
                ]),
              ),
          ],
        ),
        drawer: const GlobalDrawer());
  }
}
