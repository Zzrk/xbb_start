import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xbb_start/components/drawer.dart';
import 'package:xbb_start/components/hero.dart';
import 'package:xbb_start/controllers/hero.dart';

// 英雄养成
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
            onPressed: () => Get.toNamed('/hero_foster_config'),
          ),
        ],
      ),
      body: Obx(() => GridView.count(
            crossAxisCount: 4,
            children: c.heroList.map((hero) {
              return HeroItem(
                hero: hero,
                onTap: () => c.toggleFoster(hero),
                decoration: c.fosterList.any((element) => element.hero.name == hero.name)
                    ? const BoxDecoration(color: Colors.black26)
                    : null,
              );
            }).toList(),
          )),
      drawer: const GlobalDrawer(),
    );
  }
}
