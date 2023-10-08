import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:xbb_start/controllers/equipment.dart';
import 'package:xbb_start/utils/equipment.dart';
import 'package:xbb_start/utils/hero.dart';
import 'package:xbb_start/utils/index.dart';

class HeroInfoController extends GetxController {
  static HeroInfoController get to => Get.find();

  // 英雄列表
  var heroList = <HeroInfo>[].obs;

  // 初始化英雄列表
  Future<void> initHeroList() async {
    // TODO: 接口返回数据
    final data = await rootBundle.loadString('lib/mock/hero.json');
    heroList.value = parseHeroList(data);
  }

  // 英雄养成列表
  var fosterList = <HeroFosterInfo>[].obs;

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

  // 养成计算的装备列表
  var computedList = <EquipmentFoster>[].obs;

  // 按照装备品质排序
  void sortFoster() {
    computedList.sort((a, b) => equipmentQualityList
        .indexOf(b.equipment.quality)
        .compareTo(equipmentQualityList.indexOf(a.equipment.quality)));
  }

  // 计算养成装备
  void computeFoster() {
    // 清空原先的计算结果
    computedList.clear();
    final equipmentList = EquipmentController.to.equipmentData['total'];
    // 遍历每个需要养成的英雄
    for (HeroFosterInfo foster in fosterList) {
      // 英雄的各个阶段所需装备
      final stages = foster.hero.stages;
      // 英雄的初始阶段
      final fromIndex =
          stages.indexWhere((stage) => stage.stage == foster.from);
      // 英雄的目的阶段
      final toIndex = stages.indexWhere((stage) => stage.stage == foster.to);
      // 如果目的阶段小于初始阶段，说明英雄已经进阶到目的阶段，不需要计算
      if (toIndex < fromIndex) return;
      // 遍历英雄需要养成的各个阶段
      for (var i = fromIndex; i <= toIndex; i++) {
        // 当前阶段所需装备
        final stage = stages[i];
        // 遍历当前阶段所需装备
        for (String equipmentName in stage.equipments) {
          // 如果计算结果中已经有该装备，数量+1，否则新增
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
    sortFoster();
  }

  // 计算装备碎片
  void computeFragment() {
    // 在 computeFoster 之后调用
    // 筛选需要合成的装备
    final synthesisList = computedList
        .where((element) => element.equipment.synthesis != null)
        .toList();
    // 如果没有需要合成的装备，直接返回
    if (synthesisList.isEmpty) {
      computedList.sort((a, b) => equipmentQualityList
          .indexOf(b.equipment.quality)
          .compareTo(equipmentQualityList.indexOf(a.equipment.quality)));
      return;
    }
    // 新添加的子装备列表, 需要在最后 computedList.addAll
    final newList = <EquipmentFoster>[];
    final equipmentList = EquipmentController.to.equipmentData['total'];
    // 遍历需要合成的装备
    for (EquipmentFoster foster in synthesisList) {
      // 删除需要合成的装备
      computedList
          .removeWhere((element) => element.equipment == foster.equipment);
      final synthesis = foster.equipment.synthesis!;
      // 遍历合成所需的子装备
      for (EquipmentSynthesis synthesis in synthesis) {
        // 如果计算结果中已经有该装备，数量+父装备数量*子装备数量，否则新增
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
    // 重复调用直到没有需要合成的装备
    computeFragment();
  }
}
