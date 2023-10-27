import 'package:get/get.dart';
import 'package:xbb_start/controllers/equipment.dart';
import 'package:xbb_start/controllers/hero.dart';
import 'package:xbb_start/controllers/my_equipment.dart';
import 'package:xbb_start/declaration/equipment.dart';
import 'package:xbb_start/declaration/hero.dart';
import 'package:xbb_start/declaration/index.dart';

class FosterSummaryController extends GetxController {
  static FosterSummaryController get to => Get.find();

  // 养成计算的装备列表
  var computedItemList = <EquipmentFoster>[].obs;
  // 养成计算的碎片列表
  var computedFragmentList = <EquipmentFoster>[].obs;
  // 养成需求的装备列表
  var neededItemList = <EquipmentFoster>[].obs;
  // 养成需求的碎片列表
  var neededFragmentList = <EquipmentFoster>[].obs;

  // 按照装备品质排序
  void sortFoster(List<EquipmentFoster> computedItemList) {
    computedItemList.sort((a, b) =>
        equipmentQualityList.indexOf(b.equipment.quality).compareTo(equipmentQualityList.indexOf(a.equipment.quality)));
  }

  // 计算养成装备
  void computeFoster(List<EquipmentFoster> computedItemList) {
    final fosterList = HeroInfoController.to.fosterList;
    final equipmentList = EquipmentController.to.equipmentData['total'];
    // 清空原先的计算结果
    computedItemList.clear();
    // 遍历每个需要养成的英雄
    for (HeroFosterInfo foster in fosterList) {
      // 英雄的各个阶段所需装备
      final stages = foster.hero.stages;
      // 英雄的初始阶段
      final fromIndex = stages.indexWhere((stage) => stage.stage == foster.from);
      // 英雄的目的阶段
      final toIndex = stages.indexWhere((stage) => stage.stage == foster.to);
      // 如果目的阶段小于初始阶段，说明英雄已经进阶到目的阶段，不需要计算
      if (toIndex < fromIndex) return;
      // 遍历英雄需要养成的各个阶段
      for (var i = fromIndex; i <= toIndex; i++) {
        // 当前阶段所需装备
        final stage = stages[i];
        // 遍历当前阶段所需装备
        for (var j = 0; j < stage.equipments.length; j++) {
          final equipmentName = stage.equipments[j];
          if (equipmentName.isEmpty ||
              (i == fromIndex && ((foster.fromState >> (5 - j)) & 1 == 1)) ||
              (i == toIndex && ((foster.toState >> (5 - j)) & 1 == 0))) continue;
          // 如果计算结果中已经有该装备，数量+1，否则新增
          final equipment = equipmentList!.firstWhere((element) => element.name == equipmentName);
          if (computedItemList.any((element) => element.equipment == equipment)) {
            final computedEquipment = computedItemList.firstWhere((element) => element.equipment == equipment);
            computedEquipment.count++;
          } else {
            computedItemList.add(EquipmentFoster(equipment: equipment, count: 1));
          }
        }
      }
    }
    sortFoster(computedItemList);
  }

  // 计算装备碎片
  void computeFragment(List<EquipmentFoster> computedItemList) {
    // 在 computeFoster 之后调用
    // 筛选需要合成的装备
    final synthesisList = computedItemList.where((element) => element.equipment.synthesis != null).toList();
    // 如果没有需要合成的装备，直接返回
    if (synthesisList.isEmpty) {
      computedItemList.sort((a, b) => equipmentQualityList
          .indexOf(b.equipment.quality)
          .compareTo(equipmentQualityList.indexOf(a.equipment.quality)));
      return;
    }
    // 新添加的子装备列表, 需要在最后 computedItemList.addAll
    final newList = <EquipmentFoster>[];
    final equipmentList = EquipmentController.to.equipmentData['total'];
    // 遍历需要合成的装备
    for (EquipmentFoster foster in synthesisList) {
      // 删除需要合成的装备
      computedItemList.removeWhere((element) => element.equipment == foster.equipment);
      final synthesis = foster.equipment.synthesis!;
      // 遍历合成所需的子装备
      for (EquipmentCount synthesis in synthesis) {
        // 如果计算结果中已经有该装备，数量+父装备数量*子装备数量，否则新增
        final equipment = equipmentList!.firstWhere((element) => element.name == synthesis.name);
        if (newList.any((element) => element.equipment == equipment)) {
          final computedEquipment = newList.firstWhere((element) => element.equipment == equipment);
          computedEquipment.count += foster.count * synthesis.count;
        } else {
          newList.add(EquipmentFoster(equipment: equipment, count: foster.count * synthesis.count));
        }
      }
    }
    computedItemList.addAll(newList);
    // 重复调用直到没有需要合成的装备
    computeFragment(computedItemList);
  }

  // 计算需求装备
  void computeNeededItem() {
    neededItemList.clear();
    final itemList = MyEquipmentController.to.myEquipmentData['item']!;
    for (EquipmentFoster item in computedItemList) {
      // 当前拥有的装备数量
      final ownedCount = itemList.firstWhereOrNull((element) => element.name == item.equipment.name)?.count ?? 0;
      if (item.count <= ownedCount) continue;
      neededItemList.add(EquipmentFoster(equipment: item.equipment, count: item.count - ownedCount));
    }
  }

  // 计算需求碎片
  void computedNeededFragment() {
    neededFragmentList.clear();
    // 1. 将我的装备及碎片碎片保存到数组
    final equipmentList = EquipmentController.to.equipmentData['total']!;
    final myFragmentList = MyEquipmentController.to.myEquipmentData['fragment']!;
    final myItemList = MyEquipmentController.to.myEquipmentData['item']!;
    final myEquipmentList = [...myFragmentList, ...myItemList].map((fragment) {
      final equipment = equipmentList.firstWhere((element) => element.name == fragment.name);
      return EquipmentFoster(equipment: equipment, count: fragment.count);
    }).toList();
    // 2. 将我的装备递归拆分成碎片
    computeFragment(myEquipmentList);
    // 3. 计算的碎片数组 - 我的碎片数组
    for (EquipmentFoster item in computedFragmentList) {
      // 当前拥有的装备数量
      final ownedCount =
          myEquipmentList.firstWhereOrNull((element) => element.equipment.name == item.equipment.name)?.count ?? 0;
      if (item.count <= ownedCount) continue;
      neededFragmentList.add(EquipmentFoster(equipment: item.equipment, count: item.count - ownedCount));
    }
  }

  // 计算
  void compute() {
    computeFoster(computedItemList);
    computeFoster(computedFragmentList);
    computeFragment(computedFragmentList);

    computeNeededItem();
    computedNeededFragment();
  }
}
