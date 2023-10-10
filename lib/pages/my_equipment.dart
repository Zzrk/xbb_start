import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xbb_start/components/drawer.dart';
import 'package:xbb_start/components/equipment.dart';
import 'package:xbb_start/controllers/equipment.dart';
import 'package:xbb_start/controllers/my_equipment.dart';

// 我的装备
class MyEquipmentPage extends StatelessWidget {
  const MyEquipmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('我的装备'),
          bottom: const TabBar(
            tabs: [
              Tab(text: '装备'),
              Tab(text: '碎片'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            EquipmentContent(type: 'item'),
            EquipmentContent(type: 'fragment'),
          ],
        ),
        drawer: const GlobalDrawer(),
      ),
    );
  }
}

// 列表内容
class EquipmentContent extends StatelessWidget {
  EquipmentContent({super.key, this.type = 'item'});

  final String type;
  final MyEquipmentController c = Get.find();
  final EquipmentController c0 = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => GridView.count(
          crossAxisCount: 4,
          children: c.myEquipmentData[type]!.map((element) {
            final equipment = c0.equipmentData[type]!
                .firstWhereOrNull((e) => e.name == element.name);
            final count = element.count;

            if (equipment == null) return Text(element.name);

            return EquipmentItem(equipment: equipment, count: count);
          }).toList(),
        ));
  }
}
