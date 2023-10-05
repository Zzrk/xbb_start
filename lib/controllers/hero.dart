import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:xbb_start/utils/hero.dart';

class HeroesController extends GetxController {
  var heroList = <Hero>[].obs;

  Future<void> initHeroList() async {
    final data = await rootBundle.loadString('lib/mock/hero.json');
    heroList.value = parseHeroList(data);
  }
}
