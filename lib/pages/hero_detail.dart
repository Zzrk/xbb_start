import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xbb_start/components/drawer.dart';
import 'package:xbb_start/components/equipment.dart';
import 'package:xbb_start/components/hero.dart';
import 'package:xbb_start/controllers/equipment.dart';
import 'package:xbb_start/declaration/hero.dart';
import 'package:xbb_start/declaration/index.dart';

// 英雄图鉴
class HeroDetailPage extends StatelessWidget {
  const HeroDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final hero = Get.arguments as HeroInfo;

    return DefaultTabController(
      length: heroStageList.length,
      child: Scaffold(
        appBar: AppBar(title: const Text('英雄图鉴')),
        // TODO: Column -> ListView
        body: Column(children: [
          Row(children: [
            HeroImage(
              hero: hero,
              imageSize: 140,
            ),
            Expanded(
              child: Center(
                child: Column(
                  children: [
                    Text(
                      hero.name,
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('属性: '),
                        Image.asset(
                          'assets/hero_detail/${heroTypeMap[hero.category]}.png',
                          width: 32,
                          height: 32,
                        )
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('初始星级: '),
                        ...List.generate(
                            hero.star,
                            (index) => Image.asset(
                                  'assets/hero_detail/hero_star.png',
                                  width: 20,
                                  height: 20,
                                )).toList()
                      ],
                    ),
                  ],
                ),
              ),
            )
          ]),
          const SizedBox(height: 12),
          TabBar(
            isScrollable: true,
            tabs: heroStageList.map((stage) => Tab(text: stage)).toList(),
            labelColor: Colors.black,
          ),
          Expanded(
              child: TabBarView(
                  children: heroStageList
                      .map((stage) =>
                          HeroStageContent(stageInfo: hero.stages.where((element) => element.stage == stage).first))
                      .toList())),
        ]),
        drawer: const GlobalDrawer(),
      ),
    );
  }
}

// 英雄阶段装备
class HeroStageContent extends StatelessWidget {
  const HeroStageContent({super.key, required this.stageInfo});

  final HeroStage stageInfo;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              EquipmentRow(name: stageInfo.equipments[0]),
              EquipmentRow(name: stageInfo.equipments[1]),
              EquipmentRow(name: stageInfo.equipments[2]),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              EquipmentRow(name: stageInfo.equipments[3]),
              EquipmentRow(name: stageInfo.equipments[4]),
              EquipmentRow(name: stageInfo.equipments[5]),
            ],
          ),
        ),
      ],
    );
  }
}

// 可点击装备
class EquipmentRow extends StatelessWidget {
  const EquipmentRow({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final EquipmentController c = Get.find();
    final equipment = c.equipmentData['item']!.firstWhereOrNull((element) => element.name == name);

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          if (equipment == null) return;
          Get.toNamed('/equipment_detail?name=$name', arguments: equipment);
        },
        child: Row(
          children: [
            if (equipment != null)
              EquipmentImage(
                equipment: equipment,
                imageSize: 64,
              ),
            SizedBox(
              width: equipment != null ? 12 : 76,
              height: 64,
            ),
            Text(equipment != null ? name : '暂无数据'),
          ],
        ),
      ),
    );
  }
}
