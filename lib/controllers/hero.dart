import 'package:get/get.dart';
import 'package:xbb_start/declaration/hero.dart';
import 'package:xbb_start/declaration/index.dart';
import 'package:xbb_start/utils/request.dart';
import 'package:xbb_start/utils/storage.dart';

class HeroInfoController extends GetxController {
  static HeroInfoController get to => Get.find();

  // 英雄列表
  var heroList = <HeroInfo>[].obs;

  // 展示的英雄列表
  var showHeroList = <HeroInfo>[].obs;

  var storage = HeroStorage();

  // 初始化英雄列表
  Future<void> initHeroList(bool isNeedUpdate) async {
    final response = await (isNeedUpdate ? CommonRequest.getHero() : storage.readHero());
    heroList.value = HeroInfo.parseHeroList(response);
    showHeroList.value = heroList;
    // storage.writeHero(heroList);
  }

  // 英雄养成列表
  var fosterList = <HeroFosterInfo>[].obs;

  // 切换添加或删除英雄
  void toggleFoster(HeroInfo hero) {
    final index = fosterList.indexWhere((element) => element.hero == hero);
    if (index >= 0) {
      fosterList.removeAt(index);
    } else {
      final fosterInfo = HeroFosterInfo(hero: hero, from: '蓝+2', to: '紫+3');
      fosterList.add(fosterInfo);
    }
  }

  // 修改英雄的初始和目的状态
  void modifyFromOrTo(HeroInfo hero, String type, String value) {
    final fosterInfo = fosterList.firstWhere((foster) => foster.hero.name == hero.name);
    final index = fosterList.indexOf(fosterInfo);
    if (type == 'from') {
      fosterInfo.from = value;
    } else if (type == 'to') {
      fosterInfo.to = value;
    }
    fosterList[index] = fosterInfo;
  }

  // 修改英雄的初始和目的阶段
  void modifyFromOrToState(HeroInfo hero, String type, int idx) {
    final fosterInfo = fosterList.firstWhere((foster) => foster.hero.name == hero.name);
    final index = fosterList.indexOf(fosterInfo);
    if (type == 'from') {
      fosterInfo.fromState = (1 << (5 - idx)) ^ fosterInfo.fromState;
    } else if (type == 'to') {
      fosterInfo.toState = (1 << (5 - idx)) ^ fosterInfo.toState;
    }
    fosterList[index] = fosterInfo;
  }

  // 过滤器
  var filter = {
    'star': '',
    'category': '',
  }.obs;

  // 重置过滤器
  void resetFilter() {
    filter.value = {
      'star': '',
      'category': '',
    };
  }

  // 切换过滤器
  void toggleFilter(String key, String value) {
    filter[key] = filter[key] == value ? '' : value;
  }

  // 过滤
  void triggerFilter() {
    final star = filter['star']!;
    final category = filter['category']!;

    showHeroList.value = heroList.where((element) {
      if (star.isNotEmpty && heroStarList[element.star] != star) {
        return false;
      }

      if (category.isNotEmpty && element.category != category) {
        return false;
      }

      return true;
    }).toList();
  }
}
