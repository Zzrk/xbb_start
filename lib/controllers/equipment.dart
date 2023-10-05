import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:xbb_start/utils/equipment.dart';

class EquipmentController extends GetxController {
  static EquipmentController get to => Get.find();

  var equipmentData = {
    'item': <Equipment>[],
    'fragment': <Equipment>[],
    'total': <Equipment>[]
  }.obs;

  Future<void> initEquipmentList() async {
    final data = await rootBundle.loadString('lib/mock/equipment.json');
    final list = parseEquipmentList(data);
    equipmentData['item'] =
        list.where((element) => element.type == 'item').toList();
    equipmentData['fragment'] =
        list.where((element) => element.type == 'fragment').toList();
    equipmentData['total'] = list;
  }
}
