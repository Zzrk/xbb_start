import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xbb_start/components/drawer.dart';
import 'package:xbb_start/utils/equipment.dart';

class EquipmentPage extends StatelessWidget {
  const EquipmentPage({super.key});

  static const equipmentList = [
    Equipment(
        name: '秘法鞋',
        quality: EquipmentQuality.green,
        description: '战斗前闻一闻就会充满怒气'),
    Equipment(name: '双刀', quality: EquipmentQuality.blue),
    Equipment(
        name: '生命之球',
        quality: EquipmentQuality.green,
        description: '每个战士的居家旅行、杀人灭口的必备良药',
        access: [
          '【普通第3章】人鱼?鱼人!',
          '【普通第6章】问心',
          '【普通第9章】误会',
          '【精英第3章】人鱼?鱼人!',
          '【精英第6章】问心',
          '【精英第9章】误会',
          '英雄试炼获取',
        ]),
    Equipment(name: '智力假腿', quality: EquipmentQuality.green),
    Equipment(name: '散失卷轴', quality: EquipmentQuality.blue),
    Equipment(name: '绿鞋', quality: EquipmentQuality.green),
    Equipment(name: '暗灭卷轴', quality: EquipmentQuality.blue),
    Equipment(name: '小电锤卷轴', quality: EquipmentQuality.blue),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('装备图鉴'),
        ),
        body: GridView.count(
          crossAxisCount: 4,
          children: List.generate(equipmentList.length, (index) {
            final equipment = equipmentList[index];
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
        ),
        drawer: const GlobalDrawer());
  }
}
