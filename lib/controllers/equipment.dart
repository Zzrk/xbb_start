import 'package:get/get.dart';
import 'package:xbb_start/declaration/equipment.dart';
import 'package:xbb_start/utils/request.dart';
import 'package:xbb_start/utils/storage.dart';

class EquipmentController extends GetxController {
  // 当前控制器实例
  static EquipmentController get to => Get.find();
  // 本地存储
  var storage = EquipmentStorage();

  // ------------------- 装备 -------------------
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

  // 设置装备数据
  void setData(List<Equipment> list) {
    equipmentData['item'] = list.where((element) => element.category == 'item').toList();
    equipmentData['fragment'] = list.where((element) => element.category == 'fragment').toList();
    equipmentData['total'] = list;
    showEquipmentData['item'] = equipmentData['item']!;
    showEquipmentData['fragment'] = equipmentData['fragment']!;
  }

  // ------------------- 过滤器 -------------------
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

  // 过滤装备/碎片
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

  // 过滤
  void triggerFilter() {
    triggerFilterByType('item');
    triggerFilterByType('fragment');
  }

  // ------------------- 初始化 -------------------
  var isInit = false.obs;

  // 从本地存储中恢复数据
  Future<void> recoverFromStorage() async {
    final list = Equipment.parseEquipmentList(await storage.readEquipment());
    setData(list);
  }

  // 重新请求数据
  Future<bool> reRequest() async {
    final list = Equipment.parseEquipmentList(await CommonRequest.getEquipment() ?? []);
    if (list.isEmpty) return false;
    setData(list);
    storage.writeEquipment(list);
    return true;
  }
}
