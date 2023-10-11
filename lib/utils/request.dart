import 'package:dio/dio.dart';
import 'package:xbb_start/declaration/my_equipment.dart';

abstract class CommonRequest {
  static final dio = Dio(BaseOptions(
    contentType: 'application/json',
  ));

  static Future<List<dynamic>> getEquipmentItem() async {
    final response = await CommonRequest.dio.get(
      'http://10.0.2.2:3000/item',
    );
    return response.data;
  }

  static Future<List<dynamic>> getEquipmentFragment() async {
    final response =
        await CommonRequest.dio.get('http://10.0.2.2:3000/fragment');
    return response.data;
  }

  static updateEquipmentItem(MyEquipment payload) async {
    await CommonRequest.dio
        .patch('http://10.0.2.2:3000/item/${payload.id}', data: {
      'name': payload.name,
      'count': payload.count,
    });
  }
}
