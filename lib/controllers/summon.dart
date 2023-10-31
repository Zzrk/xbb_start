import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xbb_start/declaration/summon.dart';

class SummonController extends GetxController with GetSingleTickerProviderStateMixin {
  // 当前控制器实例
  static SummonController get to => Get.find();

  // 抽卡结果
  var summonResult = <SummonResult>[].obs;

  // 更新抽卡结果
  updateSummonResult(List<SummonResult> result) {
    summonResult.value = result;
  }

  // 剩余几次保底
  var rest = 80.obs;

  // 更新剩余几次保底
  void getNewRest() {
    var newRest = rest.value;
    for (final result in summonResult) {
      newRest = (result.probability.star == 3 && !result.probability.isFragment) ? 80 : newRest - 1;
    }
    rest.value = newRest;
  }

  late AnimationController controller;

  @override
  void onInit() {
    super.onInit();
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 5));
  }
}
