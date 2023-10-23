import 'package:get/get.dart';
import 'package:xbb_start/declaration/equipment.dart';
import 'package:xbb_start/utils/request.dart';

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

  // 装备品质列表
  var equipmentQualityList = <String>[].obs;

  // 初始化装备数据
  Future<void> initEquipmentList() async {
    final response = await CommonRequest.getEquipment();
    final list = Equipment.parseEquipmentList(response);
    equipmentData['item'] = list.where((element) => element.category == 'item').toList();
    equipmentData['fragment'] = list.where((element) => element.category == 'fragment').toList();
    equipmentData['total'] = list;

    // 获取装备品质列表
    equipmentQualityList.value = ['', ...list.map((e) => e.quality).toSet().toList()];
  }

  // 过滤器
  var filter = {
    'quality': '',
    'name': '',
  }.obs;

  // 重置过滤器
  void resetFilter() {
    filter.value = {
      'quality': '',
      'name': '',
    };
  }

  // 切换过滤器
  void toggleFilter(String key, String value) {
    filter[key] = filter[key] == value ? '' : value;
  }

  // 过滤
  void triggerFilter(String type) {
    final list = equipmentData['total']!.where((element) => element.category == type).toList();
    final quality = filter['quality']!;
    final name = filter['name']!;

    equipmentData[type] = list.where((element) {
      if (quality.isNotEmpty && element.quality != quality) {
        return false;
      }

      if (name.isNotEmpty && !element.name.contains(name)) {
        return false;
      }

      return true;
    }).toList();
  }
}
