import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xbb_start/components/drawer.dart';
import 'package:xbb_start/utils/equipment.dart';

class EquipmentPage extends StatelessWidget {
  const EquipmentPage({super.key});

  static const EquipmentList = [
    Equipment(name: '秘法鞋'),
    Equipment(name: '双刀'),
    Equipment(name: '疯脸'),
    Equipment(name: '智力假腿'),
    Equipment(name: '散失卷轴'),
    Equipment(name: '绿鞋'),
    Equipment(name: '暗灭卷轴'),
    Equipment(name: '小电锤卷轴'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('装备图鉴'),
        ),
        body: GridView.count(
          crossAxisCount: 4,
          children: List.generate(EquipmentList.length, (index) {
            final equipment = EquipmentList[index];
            return GestureDetector(
              onTap: () {
                print(equipment);
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
