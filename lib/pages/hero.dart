import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xbb_start/components/drawer.dart';
import 'package:xbb_start/components/hero.dart';
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
              return HeroItem(hero: hero);
            }).toList(),
          )),
      drawer: const GlobalDrawer(),
    );
  }
}
