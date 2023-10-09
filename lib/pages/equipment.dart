import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xbb_start/components/drawer.dart';
import 'package:xbb_start/components/equipment.dart';
import 'package:xbb_start/controllers/equipment.dart';

// 装备图鉴
class EquipmentPage extends StatelessWidget {
  const EquipmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('装备图鉴'),
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

// 图鉴列表内容
class EquipmentContent extends StatelessWidget {
  EquipmentContent({super.key, this.type = 'item'});

  final String type;
  final EquipmentController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => GridView.count(
          crossAxisCount: 4,
          children: c.equipmentData[type]!.map((equipment) {
            return EquipmentItem(equipment: equipment);
          }).toList(),
        ));
  }
}
