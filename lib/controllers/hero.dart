import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:xbb_start/utils/hero.dart';

class HeroInfoController extends GetxController {
  static HeroInfoController get to => Get.find();

  var heroList = <HeroInfo>[].obs;

  Future<void> initHeroList() async {
    final data = await rootBundle.loadString('lib/mock/hero.json');
    heroList.value = parseHeroList(data);
  }
}
