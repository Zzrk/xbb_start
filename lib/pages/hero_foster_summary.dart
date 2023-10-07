import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xbb_start/components/drawer.dart';
import 'package:xbb_start/controllers/hero.dart';

class HeroFosterSummaryPage extends StatelessWidget {
  const HeroFosterSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final HeroInfoController c = Get.find();

    return Scaffold(
        appBar: AppBar(
          title: const Text('英雄养成总结'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FosterGridView(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                      onPressed: () {
                        c.computeFoster();
                      },
                      child: const Text('整件装备计算')),
                  TextButton(
                      onPressed: () {
                        c.computeFoster();
                      },
                      child: const Text('装备碎片计算')),
                ],
              ),
              const EquipmentGridView()
            ],
          ),
        ),
        drawer: const GlobalDrawer());
  }
}

class FosterGridView extends StatelessWidget {
  FosterGridView({super.key});
  static const stageList = ['蓝+2', '紫', '紫+1', '紫+2', '紫+3'];
  final dropdownItems = stageList
      .map((e) => DropdownMenuItem(
            value: e,
            child: Text(e),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    final HeroInfoController c = Get.find();

    const itemCount = 4;
    final itemWidth = MediaQuery.of(context).size.width / itemCount;
    const itemHeight = 140;

    return Obx(() => GridView.count(
          shrinkWrap: true,
          crossAxisCount: itemCount,
          childAspectRatio: itemWidth / itemHeight,
          children: c.fosterList.map((fosterInfo) {
            final hero = fosterInfo.hero;
            final heroName = hero.name;
            final isTodo = hero.stages.any((stage) =>
                stage.equipments.any((equipment) => equipment.isEmpty));
            return Column(
              children: [
                const SizedBox(height: 8),
                Image(
                  image: Image.asset('assets/hero/$heroName.jpg').image,
                  width: 32,
                  height: 32,
                ),
                Text(heroName + (isTodo ? '*' : '')),
                const SizedBox(height: 8),
                Expanded(
                  child: DropdownButton(
                    items: dropdownItems,
                    value: fosterInfo.from,
                    onChanged: (value) =>
                        c.modifyFromOrTo(hero, 'from', value!),
                    style: const TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ),
                Expanded(
                  child: DropdownButton(
                    items: dropdownItems,
                    value: fosterInfo.to,
                    onChanged: (value) => c.modifyFromOrTo(hero, 'to', value!),
                    style: const TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ),
              ],
            );
          }).toList(),
        ));
  }
}

class EquipmentGridView extends StatelessWidget {
  const EquipmentGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final HeroInfoController c = Get.find();

    const itemCount = 4;

    return Obx(() => GridView.count(
          shrinkWrap: true,
          crossAxisCount: itemCount,
          children: c.computedList.map((element) {
            final equipment = element.equipment;
            final count = element.count;
            return Column(
              children: [
                const SizedBox(height: 8),
                Image(
                  image: Image.asset('assets/equipment/${equipment.name}.jpg')
                      .image,
                  width: 32,
                  height: 32,
                ),
                Text(equipment.name),
                Text('x$count'),
              ],
            );
          }).toList(),
        ));
  }
}
