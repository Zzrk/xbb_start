import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:xbb_start/utils/my_equipment.dart';

class MyEquipmentController extends GetxController {
  static MyEquipmentController get to => Get.find();

  // 我的装备
  var myEquipmentData = {
    'item': <MyEquipment>[],
    'fragment': <MyEquipment>[],
  }.obs;

  // 初始化装备数据
  Future<void> initMyEquipmentList() async {
    final itemResponse = await http.get(Uri.parse('http://10.0.2.2:3000/item'));
    myEquipmentData['item'] = parseMyEquipmentList(itemResponse.body);
    final fragmentResponse =
        await http.get(Uri.parse('http://10.0.2.2:3000/fragment'));
    myEquipmentData['fragment'] = parseMyEquipmentList(fragmentResponse.body);
  }
}
