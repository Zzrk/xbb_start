import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xbb_start/components/drawer.dart';
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
        title: const Text('首页'),
      ),
      body: Column(children: [
        Expanded(
          child: Obx(() => ListView.builder(
                itemCount: c.summonResult.length,
                itemBuilder: (BuildContext context, int index) {
                  final summonResult = c.summonResult[index];
                  return ListTile(
                    tileColor: summonProbabilityColor(summonResult.probability),
                    title: Text(summonResult.hero.name),
                    trailing: Text(
                      '${summonResult.probability.star}星${summonResult.probability.isFragment ? '碎片' : '英雄'}',
                      style: const TextStyle(color: Colors.black54),
                    ),
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
                c.updateSummonResult([summonOneResult(rest: c.rest.value)]);
                c.getNewRest();
              },
              child: const Text('单抽'),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                c.updateSummonResult(summonTenResult(rest: c.rest.value));
                c.getNewRest();
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
