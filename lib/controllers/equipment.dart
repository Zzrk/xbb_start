import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:xbb_start/declaration/equipment.dart';

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

  // 初始化装备数据
  Future<void> initEquipmentList() async {
    // TODO: 接口返回数据
    final data = await rootBundle.loadString('lib/mock/equipment.json');
    final list = parseEquipmentList(data);
    equipmentData['item'] = list.where((element) => element.category == 'item').toList();
    equipmentData['fragment'] = list.where((element) => element.category == 'fragment').toList();
    equipmentData['total'] = list;
  }
}
