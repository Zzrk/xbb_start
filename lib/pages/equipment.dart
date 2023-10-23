import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xbb_start/components/drawer.dart';
import 'package:xbb_start/components/equipment.dart';
import 'package:xbb_start/components/filter_button.dart';
import 'package:xbb_start/controllers/equipment.dart';

// 装备图鉴
class EquipmentPage extends StatelessWidget {
  const EquipmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final EquipmentController c = Get.find();

    return DefaultTabController(
      length: 2,
      child: Builder(
          builder: (context) => Scaffold(
                appBar: AppBar(
                  title: const Text('装备图鉴'),
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
                floatingActionButton: Obx(() => FilterButton(
                      filterMenus: [
                        SelectFilterMenu(
                          title: '装备品质',
                          value: c.filter['quality']!,
                          options: c.equipmentQualityList,
                          onChange: (value) {
                            final type = DefaultTabController.of(context).index == 0 ? 'item' : 'fragment';
                            c.toggleFilter('quality', value);
                            c.triggerFilter(type);
                          },
                        ),
                      ],
                    )),
                drawer: const GlobalDrawer(),
              )),
    );
  }
}

// 图鉴列表内容
class EquipmentContent extends StatelessWidget {
  const EquipmentContent({super.key, this.type = 'item'});

  final String type;

  @override
  Widget build(BuildContext context) {
    final EquipmentController c = Get.find();

    return Obx(() => GridView.count(
          crossAxisCount: 4,
          children: c.equipmentData[type]!.map((equipment) {
            return EquipmentItem(equipment: equipment);
          }).toList(),
        ));
  }
}
