import 'package:get/get.dart';
import 'package:xbb_start/declaration/my_equipment.dart';
import 'package:xbb_start/utils/storage.dart';

class MyEquipmentController extends GetxController {
  // 当前控制器实例
  static MyEquipmentController get to => Get.find();
  // 本地存储
  var storage = MyEquipmentStorage();

  // ------------------- 我的装备 -------------------
  // 我的装备
  var myEquipmentData = {
    'item': <MyEquipment>[].obs,
    'fragment': <MyEquipment>[].obs,
  };

  // 初始化装备数据
  Future<void> recoverFromStorage() async {
    final itemResponse = await storage.readEquipment('item');
    final fragmentResponse = await storage.readEquipment('fragment');

    myEquipmentData['item']!.value = parseMyEquipmentList(itemResponse);
    myEquipmentData['fragment']!.value = parseMyEquipmentList(fragmentResponse);
  }

  // 更新装备数据
  updateMyEquipment(String type, String name, int count) {
    final equipmentList = myEquipmentData[type]!;
    final equipment = equipmentList.firstWhereOrNull((element) => element.name == name);
    if (equipment == null) {
      equipmentList.insert(0, MyEquipment(id: equipmentList.length, name: name, count: count));
    } else {
      equipment.count = count;
      final index = myEquipmentData[type]!.indexOf(equipment);
      myEquipmentData[type]![index] = equipment;
    }
    storage.writeEquipment(type, equipmentList);
  }

  // ------------------- 下拉框 -------------------
  // 下拉框选择装备
  var selectedEquipment = '';
  updateSelectedEquipment(String name) {
    selectedEquipment = name;
  }
}
