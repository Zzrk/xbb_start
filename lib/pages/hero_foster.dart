import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xbb_start/components/drawer.dart';
import 'package:xbb_start/controllers/hero.dart';

class HeroFosterPage extends StatelessWidget {
  const HeroFosterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final HeroInfoController c = Get.find();

    return Scaffold(
        appBar: AppBar(
          title: const Text('英雄养成'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.check),
              tooltip: '确认',
              onPressed: () {
                Get.toNamed('/hero_foster_summary');
              },
            ),
          ],
        ),
        body: Obx(() => GridView.count(
              crossAxisCount: 4,
              children: c.heroList.map((hero) {
                final heroName = hero.name;
                final isTodo = hero.stages.any((stage) =>
                    stage.equipments.any((equipment) => equipment.isEmpty));
                return GestureDetector(
                  onTap: () {
                    c.toogleFoster(hero);
                  },
                  child: Container(
                    decoration: c.fosterList
                            .any((element) => element.hero.name == hero.name)
                        ? const BoxDecoration(color: Colors.black26)
                        : null,
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 12),
                          Image(
                            image:
                                Image.asset('assets/hero/$heroName.jpg').image,
                            width: 32,
                            height: 32,
                          ),
                          const SizedBox(height: 12),
                          Text(heroName + (isTodo ? '*' : '')),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            )),
        drawer: const GlobalDrawer());
  }
}
