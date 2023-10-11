import 'package:get/get.dart';
import 'package:xbb_start/utils/request.dart';
import 'package:xbb_start/declaration/my_equipment.dart';

class MyEquipmentController extends GetxController {
  static MyEquipmentController get to => Get.find();

  // 我的装备
  var myEquipmentData = {
    'item': <MyEquipment>[].obs,
    'fragment': <MyEquipment>[].obs,
  };

  // 初始化装备数据
  Future<void> initMyEquipmentList() async {
    final itemResponse = await CommonRequest.getEquipmentItem();
    myEquipmentData['item']!.value = parseMyEquipmentList(itemResponse);
    final fragmentResponse = await CommonRequest.getEquipmentFragment();
    myEquipmentData['fragment']!.value = parseMyEquipmentList(fragmentResponse);
  }

  // 更新装备数据
  updateMyEquipment(String type, String name, int count) {
    final equipment =
        myEquipmentData[type]!.firstWhere((element) => element.name == name);
    final index = myEquipmentData[type]!.indexOf(equipment);
    equipment.count = count;
    myEquipmentData[type]![index] = equipment;
  }
}
