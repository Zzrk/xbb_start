import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xbb_start/components/drawer.dart';
import 'package:xbb_start/components/filter_button.dart';
import 'package:xbb_start/components/hero.dart';
import 'package:xbb_start/controllers/hero.dart';
import 'package:xbb_start/declaration/index.dart';
import 'package:xbb_start/utils/toast.dart';

// 英雄图鉴
class HeroPage extends StatelessWidget {
  const HeroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final HeroInfoController c = Get.find();
    final toaster = CommonToast(context);

    Future<void> reRequest() async {
      final result = await c.reRequest();
      if (!result) toaster.errorRefresh();
    }

    if (!c.isInit.value) {
      // 重新请求一次
      reRequest();
      c.isInit.value = true;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('英雄图鉴')),
      body: RefreshIndicator(
        onRefresh: () => reRequest(),
        child: Obx(() => GridView.count(
              crossAxisCount: 4,
              children: c.showHeroList.map((hero) {
                return HeroItem(hero: hero);
              }).toList(),
            )),
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
      drawer: const GlobalDrawer(),
    );
  }
}
