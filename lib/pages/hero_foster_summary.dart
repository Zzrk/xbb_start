import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xbb_start/components/drawer.dart';
import 'package:xbb_start/controllers/hero.dart';

class HeroFosterSummaryPage extends StatelessWidget {
  HeroFosterSummaryPage({super.key});
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

    return Scaffold(
        appBar: AppBar(
          title: const Text('英雄养成总结'),
        ),
        body: Obx(() => GridView.count(
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
                        style:
                            const TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ),
                    Expanded(
                      child: DropdownButton(
                        items: dropdownItems,
                        value: fosterInfo.to,
                        onChanged: (value) =>
                            c.modifyFromOrTo(hero, 'to', value!),
                        style:
                            const TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ),
                  ],
                );
              }).toList(),
            )),
        drawer: const GlobalDrawer());
  }
}
