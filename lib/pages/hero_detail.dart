import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xbb_start/components/drawer.dart';
import 'package:xbb_start/controllers/equipment.dart';
import 'package:xbb_start/utils/hero.dart';
import 'package:xbb_start/utils/index.dart';

// 英雄图鉴
class HeroDetailPage extends StatelessWidget {
  const HeroDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final hero = Get.arguments as HeroInfo;

    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(title: const Text('英雄图鉴')),
        body: Column(children: [
          Row(children: [
            Image.asset('assets/hero/${hero.name}.jpg'),
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
                          'assets/hero_detail/${heroTypeMap[hero.type]}.png',
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
            tabs: heroStageList.map((stage) => Tab(text: stage)).toList(),
            labelColor: Colors.black,
          ),
          Expanded(
              child: TabBarView(
                  children: heroStageList
                      .map((stage) => HeroStageContent(
                          stageInfo: hero.stages
                              .where((element) => element.stage == stage)
                              .first))
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
  EquipmentRow({super.key, required this.name});

  final String name;
  final EquipmentController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          final equipment = c.equipmentData['total']!
              .where((element) => element.name == name)
              .first;
          Get.toNamed('/equipment_detail?name=$name', arguments: equipment);
        },
        child: Row(
          children: [
            if (name.isNotEmpty)
              Image.asset(
                'assets/equipment/$name.jpg',
                width: 64,
                height: 64,
              ),
            SizedBox(
              width: name.isNotEmpty ? 12 : 76,
              height: 64,
            ),
            Text(name.isNotEmpty ? name : '暂无数据'),
          ],
        ),
      ),
    );
  }
}
