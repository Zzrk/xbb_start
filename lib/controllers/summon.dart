import 'package:get/get.dart';
import 'package:xbb_start/declaration/summon.dart';

class SummonController extends GetxController {
  static SummonController get to => Get.find();

  // 抽卡结果
  var summonResult = <SummonResult>[].obs;

  // 更新抽卡结果
  updateSummonResult(List<SummonResult> result) {
    summonResult.value = result;
  }
}
