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
                    title: Text(summonResult.hero.name),
                    subtitle:
                        Text('${summonResult.probability.star}星${summonResult.probability.isFragment ? '碎片' : '英雄'}'),
                  );
                },
              )),
        ),
        ElevatedButton(
          onPressed: () {
            c.updateSummonResult(getSummonResult());
          },
          child: const Text('十连抽'),
        ),
      ]),
      drawer: const GlobalDrawer(),
    );
  }
}
