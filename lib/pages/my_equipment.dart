import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:xbb_start/components/drawer.dart';
import 'package:xbb_start/components/equipment.dart';
import 'package:xbb_start/controllers/equipment.dart';
import 'package:xbb_start/controllers/my_equipment.dart';
import 'package:xbb_start/utils/toast.dart';

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
        body: const TabBarView(
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
  const EquipmentContent({super.key, this.type = 'item'});

  final String type;

  @override
  Widget build(BuildContext context) {
    final MyEquipmentController c = Get.find();
    final EquipmentController c0 = Get.find();
    final myController = TextEditingController();
    final toaster = CommonToast(context);

    return Obx(() => GridView.count(
          crossAxisCount: 4,
          children: c.myEquipmentData[type]!.map((element) {
            final equipment = c0.equipmentData[type]!.firstWhere((e) => e.name == element.name);

            return EquipmentItem(
              equipment: equipment,
              count: element.count,
              onLongPress: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => Dialog(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            '修改装备数量',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(equipment.name),
                          const SizedBox(height: 8),
                          TextField(
                            controller: myController,
                            decoration: const InputDecoration(border: OutlineInputBorder(), hintText: '输入装备数量'),
                          ),
                          const SizedBox(height: 8),
                          TextButton(
                            child: const Text('确认'),
                            onPressed: () async {
                              final newCount = int.parse(myController.text);
                              element.count = newCount;
                              c.updateMyEquipment(type, equipment.name, newCount);
                              toaster.showToast('修改成功');
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ));
  }
}
