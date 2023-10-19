import 'dart:math';
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

// 一次抽卡
SummonProbability summonOnce() {
  final summonProbabilityList = [
    const SummonProbability(star: 1, isFragment: false, probability: 0.1998),
    const SummonProbability(star: 2, isFragment: false, probability: 0.0439),
    const SummonProbability(star: 3, isFragment: false, probability: 0.0171),
    const SummonProbability(star: 1, isFragment: true, probability: 0.5644),
    const SummonProbability(star: 2, isFragment: true, probability: 0.1498),
    const SummonProbability(star: 3, isFragment: true, probability: 0.0250),
  ];

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
List<SummonProbability> summonTenTimes() {
  return List.generate(10, (_) => summonOnce());
}

// 十连抽结果
List<SummonResult> getSummonResult() {
  final summonProbabilityList = summonTenTimes();
  final summonResultList = <SummonResult>[];

  for (final summonProbability in summonProbabilityList) {
    final heroList = HeroInfoController.to.heroList.where((element) => element.star == summonProbability.star);
    final hero = heroList.elementAt(Random().nextInt(heroList.length));
    summonResultList.add(SummonResult(hero: hero, probability: summonProbability));
  }

  return summonResultList;
}
