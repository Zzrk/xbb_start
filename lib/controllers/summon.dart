import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xbb_start/declaration/summon.dart';

class SummonController extends GetxController with GetSingleTickerProviderStateMixin {
  // 当前控制器实例
  static SummonController get to => Get.find();

  // 抽卡结果
  var summonResult = <SummonResult>[].obs;

  // 抽卡结果对话框列表, 用于 pop
  var showResult = <SummonResult>[].obs;

  // 点击抽卡结果
  void popResult() {
    showResult.removeAt(0);
  }

  // 更新抽卡结果
  void updateSummonResult(List<SummonResult> result) {
    summonResult.value = result;
    showResult.value = result;
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

  // 动画控制器
  late AnimationController controller;

  // 开始动画
  void animate() {
    controller.reset();
    controller.forward();
  }

  @override
  void onInit() {
    super.onInit();
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
  }
}
