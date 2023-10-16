import 'package:dio/dio.dart';
import 'package:xbb_start/declaration/my_equipment.dart';

abstract class CommonRequest {
  // 请求实例
  static final dio = Dio(BaseOptions(
    contentType: 'application/json',
    baseUrl: 'http://10.0.2.2:8000',
  ));

  // 请求我的装备
  static Future<List<dynamic>> getEquipmentItem() async {
    final response = await CommonRequest.dio.get(
      '/item',
    );
    return response.data;
  }

  // 请求我的碎片
  static Future<List<dynamic>> getEquipmentFragment() async {
    final response = await CommonRequest.dio.get('/fragment');
    return response.data;
  }

  // 更新我的装备
  static updateEquipmentItem(MyEquipment payload) async {
    await CommonRequest.dio.patch('/item/${payload.id}', data: {
      'name': payload.name,
      'count': payload.count,
    });
  }

  // 请求活动日历数据
  static Future<List<dynamic>> getCalendarData() async {
    final response = await CommonRequest.dio.get('/calendar/all');
    return response.data;
  }
}
