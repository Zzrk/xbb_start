import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xbb_start/components/drawer.dart';
import 'package:xbb_start/components/hero.dart';
import 'package:xbb_start/controllers/summon.dart';
import 'package:xbb_start/declaration/summon.dart';

// 召唤
class SummonPage extends StatelessWidget {
  const SummonPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SummonController c = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text('召唤模拟'),
      ),
      body: Column(children: [
        Expanded(
          child: Obx(() => ListView.builder(
                itemCount: c.summonResult.length,
                itemBuilder: (BuildContext context, int index) {
                  final summonResult = c.summonResult[index];
                  return AnimatedBuilder(
                    animation: c.controller,
                    builder: (BuildContext context, Widget? child) {
                      final opacity = Tween<double>(begin: 0, end: 1)
                          .animate(CurvedAnimation(
                            parent: c.controller,
                            curve: Interval(index * 0.1, (index + 1) * 0.1),
                          ))
                          .value;

                      return Opacity(
                        opacity: Get.isDialogOpen! ? 0 : opacity,
                        child: ListTile(
                          tileColor: summonProbabilityColor(summonResult.probability).withOpacity(opacity),
                          title: Text(summonResult.hero.name),
                          trailing: Text(
                            '${summonResult.probability.star}星${summonResult.probability.isFragment ? '碎片' : '英雄'}',
                            style: const TextStyle(color: Colors.black54),
                          ),
                        ),
                      );
                    },
                  );
                },
              )),
        ),
        Obx(() => Text('剩余几次保底：${c.rest.value}')),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                final result = [summonOneResult(rest: c.rest.value)];
                c.updateSummonResult(result);
                c.getNewRest();
                openSummonDialog(result);
              },
              child: const Text('单抽'),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                final result = summonTenResult(rest: c.rest.value);
                c.updateSummonResult(result);
                c.getNewRest();
                openSummonDialog(result);
              },
              child: const Text('十连抽'),
            ),
          ],
        )
      ]),
      drawer: const GlobalDrawer(),
    );
  }
}

void openSummonDialog(List<SummonResult> result) {
  final SummonController c = Get.find();
  // 临时全屏窗口
  Get.dialog(
    GestureDetector(
      onTap: () {
        if (c.showResult.length > 1) {
          c.popResult();
        } else {
          Get.back();
          c.animate();
        }
      },
      child: Obx(() {
        final summonResult = c.showResult.first;
        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                summonProbabilityColor(summonResult.probability),
                summonProbabilityColor(summonResult.probability).withOpacity(0.2),
              ],
              stops: const [0.5, 1],
            ),
          ),
          child: Center(
            child: AnimatedBuilder(
              animation: c.controller,
              builder: (context, child) {
                return HeroImage(
                  hero: summonResult.hero,
                  imageSize: 100,
                  isFragment: summonResult.probability.isFragment,
                );
              },
            ),
          ),
        );
      }),
    ),
  );
}
