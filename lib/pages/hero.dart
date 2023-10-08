import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xbb_start/components/drawer.dart';
import 'package:xbb_start/controllers/hero.dart';

// 英雄图鉴
class HeroPage extends StatelessWidget {
  const HeroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final HeroInfoController c = Get.find();

    return Scaffold(
      appBar: AppBar(title: const Text('英雄图鉴')),
      body: Obx(() => GridView.count(
            crossAxisCount: 4,
            children: c.heroList.map((hero) {
              final heroName = hero.name;
              final isTodo = hero.stages.any((stage) =>
                  stage.equipments.any((equipment) => equipment.isEmpty));
              return GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  Get.toNamed('/hero_detail', arguments: hero);
                },
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    Image.asset(
                      'assets/hero/$heroName.jpg',
                      width: 32,
                      height: 32,
                    ),
                    const SizedBox(height: 12),
                    Text(heroName + (isTodo ? '*' : '')),
                  ],
                ),
              );
            }).toList(),
          )),
      drawer: const GlobalDrawer(),
    );
  }
}
