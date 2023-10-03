import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xbb_start/components/drawer.dart';
import 'package:xbb_start/controllers/equipment.dart';
import 'package:xbb_start/utils/equipment.dart';

class EquipmentPage extends StatelessWidget {
  const EquipmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final EquipmentController c = Get.put(EquipmentController());
    c.initEquipmentList();

    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: const Text('装备图鉴'),
              bottom: const TabBar(tabs: [
                Tab(text: '装备'),
                Tab(text: '碎片'),
              ]),
            ),
            body: TabBarView(
              children: [
                EquipmentContent(type: 'item'),
                EquipmentContent(type: 'fragment'),
              ],
            ),
            drawer: const GlobalDrawer()));
  }
}

class EquipmentContent extends StatelessWidget {
  EquipmentContent({super.key, this.type = 'item'});

  final String type;
  final EquipmentController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => GridView.count(
          crossAxisCount: 4,
          children: c.equipmentData[type]!.map((equipment) {
            final equipmentName = equipment.name.replaceAll('(碎片)', '');
            return GestureDetector(
              onTap: () {
                Get.toNamed('/equipment_detail', arguments: equipment);
              },
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    Image(
                      image: Image.asset('assets/equipment/$equipmentName.jpg')
                          .image,
                      width: 32,
                      height: 32,
                    ),
                    const SizedBox(height: 12),
                    Text(equipmentName),
                  ],
                ),
              ),
            );
          }).toList(),
          // children: List.generate(c.equipmentItemList.length, (index) {
          //   final equipment = c.equipmentItemList[index] as EquipmentItem;
          //   return GestureDetector(
          //     onTap: () {
          //       Get.toNamed('/equipment_detail', arguments: equipment);
          //     },
          //     child: Center(
          //       child: Column(
          //         children: [
          //           const SizedBox(height: 12),
          //           Image(
          //             image: Image.asset(
          //                     'assets/equipment/${equipment.name.replaceAll('(碎片)', '')}.jpg')
          //                 .image,
          //             width: 32,
          //             height: 32,
          //           ),
          //           const SizedBox(height: 12),
          //           Text(equipment.name),
          //         ],
          //       ),
          //     ),
          //   );
          // }),
        ));
  }
}
