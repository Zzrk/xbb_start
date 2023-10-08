import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:xbb_start/controllers/equipment.dart';
import 'package:xbb_start/utils/equipment.dart';
import 'package:xbb_start/utils/hero.dart';

class HeroInfoController extends GetxController {
  static HeroInfoController get to => Get.find();

  // 英雄列表
  var heroList = <HeroInfo>[].obs;

  // 初始化英雄列表
  Future<void> initHeroList() async {
    final data = await rootBundle.loadString('lib/mock/hero.json');
    heroList.value = parseHeroList(data);
  }

  // 英雄养成列表
  var fosterList = <HeroFosterInfo>[].obs;

  // 添加英雄至英雄养成列表
  void addFoster(HeroInfo hero) {
    fosterList.add(HeroFosterInfo(hero: hero, from: '蓝+2', to: '紫+3'));
  }

  // 从英雄列表删除英雄
  void removeFoster(HeroInfo hero) {
    fosterList.remove(HeroFosterInfo(hero: hero, from: '蓝+2', to: '紫+3'));
  }

  // 切换添加或删除英雄
  void toogleFoster(HeroInfo hero) {
    final index = fosterList.indexWhere((element) => element.hero == hero);
    if (index >= 0) {
      fosterList.removeAt(index);
    } else {
      final fosterInfo = HeroFosterInfo(hero: hero, from: '蓝+2', to: '紫+3');
      fosterList.add(fosterInfo);
    }
  }

  // 修改英雄的初始和目的阶段
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

  static const qualityList = ['白', '绿', '蓝', '紫'];
  // 养成计算的装备列表
  var computedList = <EquipmentFoster>[].obs;

  // 计算养成装备
  void computeFoster() {
    computedList.clear();
    final equipmentList = EquipmentController.to.equipmentData['total'];
    for (HeroFosterInfo foster in fosterList) {
      final stages = foster.hero.stages;
      final fromIndex =
          stages.indexWhere((stage) => stage.stage == foster.from);
      final toIndex = stages.indexWhere((stage) => stage.stage == foster.to);
      if (toIndex < fromIndex) return;
      for (var i = fromIndex; i <= toIndex; i++) {
        final stage = stages[i];
        for (String equipmentName in stage.equipments) {
          final equipment = equipmentList!
              .firstWhere((element) => element.name == equipmentName);
          if (computedList.any((element) => element.equipment == equipment)) {
            final computedEquipment = computedList
                .firstWhere((element) => element.equipment == equipment);
            computedEquipment.count++;
          } else {
            computedList.add(EquipmentFoster(equipment: equipment, count: 1));
          }
        }
      }
    }
    computedList.sort((a, b) => qualityList
        .indexOf(b.equipment.quality)
        .compareTo(qualityList.indexOf(a.equipment.quality)));
  }

  // 计算装备碎片
  void computeFragment() {
    final synthesisList = computedList
        .where((element) => element.equipment.synthesis != null)
        .toList();
    if (synthesisList.isEmpty) {
      computedList.sort((a, b) => qualityList
          .indexOf(b.equipment.quality)
          .compareTo(qualityList.indexOf(a.equipment.quality)));
      return;
    }
    final newList = <EquipmentFoster>[];
    final equipmentList = EquipmentController.to.equipmentData['total'];
    for (EquipmentFoster foster in synthesisList) {
      computedList
          .removeWhere((element) => element.equipment == foster.equipment);
      final synthesis = foster.equipment.synthesis!;
      for (EquipmentSynthesis synthesis in synthesis) {
        final equipment = equipmentList!
            .firstWhere((element) => element.name == synthesis.name);
        if (newList.any((element) => element.equipment == equipment)) {
          final computedEquipment =
              newList.firstWhere((element) => element.equipment == equipment);
          computedEquipment.count += foster.count * synthesis.count;
        } else {
          newList.add(EquipmentFoster(
              equipment: equipment, count: foster.count * synthesis.count));
        }
      }
    }
    computedList.addAll(newList);
    computeFragment();
  }
}
