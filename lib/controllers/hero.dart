import 'package:get/get.dart';
import 'package:xbb_start/declaration/hero.dart';
import 'package:xbb_start/declaration/index.dart';
import 'package:xbb_start/utils/request.dart';
import 'package:xbb_start/utils/storage.dart';

class HeroInfoController extends GetxController {
  // 当前控制器实例
  static HeroInfoController get to => Get.find();
  // 本地存储
  var storage = HeroStorage();

  // ------------------- 英雄 -------------------
  // 英雄列表
  var heroList = <HeroInfo>[].obs;

  // 展示的英雄列表
  var showHeroList = <HeroInfo>[].obs;

  // 从本地存储中恢复数据
  Future<void> recoverFromFile() async {
    final list = HeroInfo.parseHeroList(await storage.readHero());
    heroList.value = list;
    showHeroList.value = list;
  }

  // 重新请求数据
  Future<void> reRequest() async {
    final list = HeroInfo.parseHeroList(await CommonRequest.getHero() ?? []);
    if (list.isEmpty) return;
    heroList.value = list;
    showHeroList.value = list;
    storage.writeHero(list);
  }

  // 初始化英雄列表
  Future<void> initHeroList() async {
    await recoverFromFile();
    await reRequest();
  }

  // ------------------- 英雄养成 -------------------
  // 英雄养成列表
  var fosterList = <HeroFosterInfo>[].obs;

  // 切换添加或删除英雄
  void toggleFoster(HeroInfo hero) {
    final index = fosterList.indexWhere((element) => element.hero == hero);
    if (index >= 0) {
      fosterList.removeAt(index);
    } else {
      final fosterInfo = HeroFosterInfo(hero: hero, from: heroStageList.first, to: heroStageList.last);
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

  // ------------------- 过滤器 -------------------
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
      if (star.isNotEmpty && heroStarList[element.star - 1] != star) {
        return false;
      }

      if (category.isNotEmpty && element.category != category) {
        return false;
      }

      return true;
    }).toList();
  }
}
