import 'package:dio/dio.dart';

abstract class CommonRequest {
  // 请求实例
  static final dio = Dio(BaseOptions(
    contentType: 'application/json',
    baseUrl: 'http://10.0.2.2:8000',
  ));

  // 请求活动日历数据
  static Future<List<dynamic>> getCalendarData() async {
    final response = await CommonRequest.dio.get('/calendar/all');
    return response.data;
  }

  // 请求兑换码数据
  static Future<List<dynamic>> getRedeemCode() async {
    final response = await CommonRequest.dio.get('/calendar/all_codes');
    return response.data;
  }

  // 请求装备图鉴数据
  static Future<List<dynamic>> getEquipment() async {
    final response = await CommonRequest.dio.get('/equipment/all');
    return response.data;
  }

  // 请求英雄图鉴数据
  static Future<List<dynamic>> getHero() async {
    final response = await CommonRequest.dio.get('/hero/all');
    return response.data;
  }
}
