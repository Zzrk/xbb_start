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
                Image.asset('assets/equipment/${equipment.name}.jpg'),
                Expanded(
                  child: Center(
                    child: Column(
                      children: [
                        Text(equipment.name),
                        const SizedBox(height: 12),
                        Text('品质: ${equipment.quality}'),
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
                  const ListTile(
                    title: Text('装备描述'),
                  ),
                  const Divider(),
                  Text(equipment.description),
                  const SizedBox(height: 12)
                ]),
              ),
            if (equipment.access != null && equipment.access!.isNotEmpty)
              Card(
                child: Column(children: [
                  const ListTile(
                    title: Text('获取途径'),
                  ),
                  const Divider(),
                  ...List.generate(equipment.access!.length,
                      (index) => Text(equipment.access![index])),
                  const SizedBox(height: 12)
                ]),
              ),
          ],
        ),
        drawer: const GlobalDrawer());
  }
}
