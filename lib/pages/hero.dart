import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xbb_start/components/drawer.dart';
import 'package:xbb_start/components/filter_button.dart';
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
            children: c.showHeroList.map((hero) {
              return HeroItem(hero: hero);
            }).toList(),
          )),
      floatingActionButton: Obx(() => FilterButton(
            filterMenus: [
              SelectFilterMenu(
                title: '星级',
                value: c.filter['star']!,
                options: ['', '一星', '二星', '三星'],
                onChange: (value) {
                  c.toggleFilter('star', value);
                  c.triggerFilter();
                },
              ),
              SelectFilterMenu(
                title: '属性',
                value: c.filter['category']!,
                options: ['', '力', '智', '敏'],
                onChange: (value) {
                  c.toggleFilter('category', value);
                  c.triggerFilter();
                },
              ),
            ],
          )),
      drawer: const GlobalDrawer(),
    );
  }
}
