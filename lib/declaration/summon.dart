import 'dart:math';
import 'package:flutter/material.dart';
import 'package:xbb_start/controllers/hero.dart';
import 'package:xbb_start/declaration/hero.dart';

// 抽卡概率
class SummonProbability {
  // 星级
  final int star;
  // 是否碎片
  final bool isFragment;
  // 概率
  final double probability;

  const SummonProbability({
    required this.star,
    required this.isFragment,
    required this.probability,
  });
}

// 抽卡结果
class SummonResult {
  // 抽到的英雄
  final HeroInfo hero;
  // 抽到的概率
  final SummonProbability probability;

  const SummonResult({
    required this.hero,
    required this.probability,
  });
}

// 抽卡概率列表
final summonProbabilityList = [
  const SummonProbability(star: 1, isFragment: false, probability: 0.1998),
  const SummonProbability(star: 2, isFragment: false, probability: 0.0439),
  const SummonProbability(star: 3, isFragment: false, probability: 0.0171),
  const SummonProbability(star: 1, isFragment: true, probability: 0.5644),
  const SummonProbability(star: 2, isFragment: true, probability: 0.1498),
  const SummonProbability(star: 3, isFragment: true, probability: 0.0250),
];

// 一次抽卡
SummonProbability summonOneTime({int rest = 80}) {
  // 80 抽保底
  if (rest == 1) return summonProbabilityList.firstWhere((element) => element.star == 3 && !element.isFragment);

  final random = Random();
  final randomValue = random.nextDouble();
  var totalProbability = 0.0;
  final summonProbability = summonProbabilityList.firstWhere((element) {
    totalProbability += element.probability;
    return totalProbability > randomValue;
  });

  return summonProbability;
}

// 十连抽
List<SummonProbability> summonTenTimes({int rest = 80}) {
  return List.generate(10, (_) {
    final res = summonOneTime(rest: rest);
    // 保底重置
    rest = (res.star == 3 && !res.isFragment) ? 80 : rest - 1;
    return res;
  });
}

// 一次抽卡结果
SummonResult summonOneResult({int rest = 80}) {
  final summonProbability = summonOneTime(rest: rest);
  final heroList = HeroInfoController.to.heroList.where((element) => element.star == summonProbability.star);
  final hero = heroList.elementAt(Random().nextInt(heroList.length));
  return SummonResult(hero: hero, probability: summonProbability);
}

// 十连抽结果
List<SummonResult> summonTenResult({int rest = 80}) {
  final summonProbabilityList = summonTenTimes(rest: rest);
  final summonResultList = <SummonResult>[];

  for (final summonProbability in summonProbabilityList) {
    final heroList = HeroInfoController.to.heroList.where((element) => element.star == summonProbability.star);
    final hero = heroList.elementAt(Random().nextInt(heroList.length));
    summonResultList.add(SummonResult(hero: hero, probability: summonProbability));
  }

  return summonResultList;
}

// 抽卡概率颜色
Color summonProbabilityColor(SummonProbability summonProbability) {
  if (summonProbability.isFragment) return Colors.greenAccent[100]!;
  if (summonProbability.star == 1) return Colors.blueAccent[100]!;
  if (summonProbability.star == 2) return Colors.purpleAccent[100]!;
  if (summonProbability.star == 3) return Colors.orangeAccent[100]!;
  return Colors.white;
}
