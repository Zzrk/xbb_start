import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xbb_start/components/hero.dart';
import 'package:xbb_start/controllers/hero.dart';
import 'package:xbb_start/pages/hero_foster_sumamry/stage_column.dart';

// 选择的养成英雄
class FosterGridView extends StatelessWidget {
  const FosterGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final HeroInfoController c = Get.find();

    const itemCount = 2;
    final itemWidth = MediaQuery.of(context).size.width / itemCount;
    const itemHeight = 160;

    return Obx(() => GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: itemCount,
          childAspectRatio: itemWidth / itemHeight,
          children: c.fosterList.map((fosterInfo) {
            final hero = fosterInfo.hero;

            return Column(
              children: [
                HeroItem(
                  hero: hero,
                  outerPadding: const EdgeInsets.all(0),
                  innerPadding: const EdgeInsets.all(8.0),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    StageColumn(
                      fosterInfo: fosterInfo,
                      type: 'from',
                    ),
                    StageColumn(
                      fosterInfo: fosterInfo,
                      type: 'to',
                    ),
                  ],
                ),
              ],
            );
          }).toList(),
        ));
  }
}
