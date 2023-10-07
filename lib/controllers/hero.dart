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

  var fosterList = <HeroFosterInfo>[].obs;

  void addFoster(HeroInfo hero) {
    fosterList.add(HeroFosterInfo(hero: hero, from: '蓝+2', to: '紫+3'));
  }

  void removeFoster(HeroInfo hero) {
    fosterList.remove(HeroFosterInfo(hero: hero, from: '蓝+2', to: '紫+3'));
  }

  void toogleFoster(HeroInfo hero) {
    final fosterInfo = HeroFosterInfo(hero: hero, from: '蓝+2', to: '紫+3');
    if (fosterList.contains(fosterInfo)) {
      fosterList.remove(fosterInfo);
    } else {
      fosterList.add(fosterInfo);
    }
  }

  void modifyFromOrTo(HeroInfo hero, String type, String value) {
    final fosterInfo =
        fosterList.firstWhere((foster) => foster.hero.name == hero.name);
    final index = fosterList.indexOf(fosterInfo);
    if (type == 'from') {
      fosterInfo.from = value;
    } else if (type == 'to') {
      fosterInfo.to = value;
    }
    fosterList[index] = fosterInfo;
  }
}
