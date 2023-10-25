import 'package:get/get.dart';
import 'package:xbb_start/declaration/equipment.dart';
import 'package:xbb_start/utils/request.dart';
import 'package:xbb_start/utils/storage.dart';

class EquipmentController extends GetxController {
  static EquipmentController get to => Get.find();

  // 装备数据
  var equipmentData = {
    // 整件
    'item': <Equipment>[],
    // 碎片
    'fragment': <Equipment>[],
    // 全部
    'total': <Equipment>[]
  }.obs;

  var showEquipmentData = {
    // 整件
    'item': <Equipment>[],
    // 碎片
    'fragment': <Equipment>[],
  }.obs;

  var storage = EquipmentStorage();

  // 初始化装备数据
  Future<void> initEquipmentList(bool isNeedUpdate) async {
    final response = await (isNeedUpdate ? CommonRequest.getEquipment() : storage.readEquipment());
    final list = Equipment.parseEquipmentList(response);
    equipmentData['item'] = list.where((element) => element.category == 'item').toList();
    equipmentData['fragment'] = list.where((element) => element.category == 'fragment').toList();
    equipmentData['total'] = list;
    showEquipmentData['item'] = equipmentData['item']!;
    showEquipmentData['fragment'] = equipmentData['fragment']!;
    storage.writeEquipment(equipmentData['total']!);
  }

  // 过滤器
  var filter = {
    'quality': '',
  }.obs;

  // 重置过滤器
  void resetFilter() {
    filter.value = {
      'quality': '',
    };
  }

  // 切换过滤器
  void toggleFilter(String key, String value) {
    filter[key] = filter[key] == value ? '' : value;
  }

  // 过滤
  void triggerFilterByType(String type) {
    final list = equipmentData['total']!.where((element) => element.category == type).toList();
    final quality = filter['quality']!;

    showEquipmentData[type] = list.where((element) {
      if (quality.isNotEmpty && element.quality != quality) {
        return false;
      }

      return true;
    }).toList();
  }

  void triggerFilter() {
    triggerFilterByType('item');
    triggerFilterByType('fragment');
  }
}
