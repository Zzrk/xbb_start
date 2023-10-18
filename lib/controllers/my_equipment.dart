import 'package:get/get.dart';
import 'package:xbb_start/declaration/my_equipment.dart';
import 'package:xbb_start/utils/storage.dart';

class MyEquipmentController extends GetxController {
  static MyEquipmentController get to => Get.find();

  // 我的装备
  var myEquipmentData = {
    'item': <MyEquipment>[].obs,
    'fragment': <MyEquipment>[].obs,
  };

  var storage = EquipmentStorage();

  // 初始化装备数据
  Future<void> initMyEquipmentList() async {
    final itemResponse = await storage.readEquipment('item');
    final fragmentResponse = await storage.readEquipment('fragment');

    myEquipmentData['item']!.value = parseMyEquipmentList(itemResponse);
    myEquipmentData['fragment']!.value = parseMyEquipmentList(fragmentResponse);
  }

  // 更新装备数据
  updateMyEquipment(String type, String name, int count) {
    final equipment = myEquipmentData[type]!.firstWhere((element) => element.name == name);
    final index = myEquipmentData[type]!.indexOf(equipment);
    equipment.count = count;
    myEquipmentData[type]![index] = equipment;
    storage.writeEquipment(type, myEquipmentData[type]!);
  }
}
