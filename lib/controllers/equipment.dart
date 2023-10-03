import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:xbb_start/utils/equipment.dart';

class EquipmentController extends GetxController {
  var equipmentItemList = [].obs;

  Future<void> initEquipmentList() async {
    final data = await rootBundle.loadString('lib/mock/equipment.json');
    equipmentItemList.value = parseEquipmentList(data);
  }
}
