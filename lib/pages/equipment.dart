import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xbb_start/components/drawer.dart';
import 'package:xbb_start/controllers/equipment.dart';

class EquipmentPage extends StatelessWidget {
  const EquipmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final EquipmentController c = Get.put(EquipmentController());
    c.initEquipmentList();

    return Scaffold(
        appBar: AppBar(
          title: const Text('装备图鉴'),
        ),
        body: Obx(() => GridView.count(
              crossAxisCount: 4,
              children: List.generate(c.equipmentList.length, (index) {
                final equipment = c.equipmentList[index];
                return GestureDetector(
                  onTap: () {
                    Get.toNamed('/equipment_detail', arguments: equipment);
                  },
                  child: Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 12),
                        Image(
                          image: equipment.image,
                          width: 32,
                          height: 32,
                        ),
                        const SizedBox(height: 12),
                        Text(equipment.name),
                      ],
                    ),
                  ),
                );
              }),
            )),
        drawer: const GlobalDrawer());
  }
}
