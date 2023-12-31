import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xbb_start/components/drawer.dart';
import 'package:xbb_start/components/filter_button.dart';
import 'package:xbb_start/components/hero.dart';
import 'package:xbb_start/controllers/hero.dart';
import 'package:xbb_start/declaration/index.dart';

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
      floatingActionButton: Obx(() => FilterButton(
            filterMenus: [
              SelectFilterMenu(
                title: '星级',
                value: c.filter['star']!,
                options: heroStarList,
                onChange: (value) {
                  c.toggleFilter('star', value);
                  c.triggerFilter();
                },
              ),
              SelectFilterMenu(
                title: '属性',
                value: c.filter['category']!,
                options: heroTypeList,
                onChange: (value) {
                  c.toggleFilter('category', value);
                  c.triggerFilter();
                },
              ),
            ],
          )),
      body: Obx(() => GridView.builder(
            itemCount: c.showHeroList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
            itemBuilder: (context, index) {
              final hero = c.showHeroList[index];
              return Obx(() => HeroItem(
                    hero: hero,
                    onTap: () => c.toggleFoster(hero),
                    decoration: c.fosterList.any((element) => element.hero.name == hero.name)
                        ? const BoxDecoration(color: Colors.black26)
                        : null,
                  ));
            },
          )),
      drawer: const GlobalDrawer(),
    );
  }
}
