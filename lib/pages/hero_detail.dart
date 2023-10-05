import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xbb_start/components/drawer.dart';
import 'package:xbb_start/controllers/equipment.dart';
import 'package:xbb_start/utils/hero.dart';

class HeroDetailPage extends StatelessWidget {
  const HeroDetailPage({super.key});

  static const stageList = ['蓝+2', '紫', '紫+1', '紫+2', '紫+3'];

  @override
  Widget build(BuildContext context) {
    final hero = Get.arguments as HeroInfo;

    return DefaultTabController(
      length: 6,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('英雄图鉴'),
          ),
          body: Column(children: [
            Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/hero/${hero.name}.jpg'),
                Expanded(
                  child: Center(
                    child: Column(
                      children: [
                        Text(hero.name),
                        const SizedBox(height: 12),
                        Text('属性: ${hero.type}'),
                        const SizedBox(height: 12),
                        Text('初始星级: ${hero.star}'),
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 12),
            TabBar(
              tabs: stageList.map((stage) => Tab(text: stage)).toList(),
              labelColor: Colors.black,
            ),
            Expanded(
                child: TabBarView(
                    children: stageList
                        .map((stage) => HeroStageContent(
                            stageInfo: hero.stages
                                .where((element) => element.stage == stage)
                                .first))
                        .toList()))
          ]),
          drawer: const GlobalDrawer()),
    );
  }
}

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
        )),
        Expanded(
            child: Column(
          children: [
            EquipmentRow(name: stageInfo.equipments[3]),
            EquipmentRow(name: stageInfo.equipments[4]),
            EquipmentRow(name: stageInfo.equipments[5]),
          ],
        )),
      ],
    );
  }
}

class EquipmentRow extends StatelessWidget {
  EquipmentRow({super.key, required this.name});

  final String name;
  final EquipmentController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: GestureDetector(
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
            Text(name.isNotEmpty ? name : '暂无数据')
          ],
        ),
      ),
    );
  }
}
