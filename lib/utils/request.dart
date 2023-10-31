import 'package:dio/dio.dart';
import 'package:xbb_start/utils/logger.dart';

abstract class CommonRequest {
  // 请求实例
  static final dio = Dio(BaseOptions(
    contentType: 'application/json',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
  ));

  static setup(String baseUrl) {
    dio.options.baseUrl = baseUrl;
  }

  // 请求活动日历数据
  static Future<List<dynamic>?> getCalendarData() async {
    try {
      final response = await CommonRequest.dio.get('/calendar/all');
      return response.data;
    } catch (err) {
      CommonLogger.error(err);
      return null;
    }
  }

  // 请求兑换码数据
  static Future<List<dynamic>?> getRedeemCode() async {
    try {
      final response = await CommonRequest.dio.get('/calendar/all_codes');
      return response.data;
    } catch (err) {
      CommonLogger.error(err);
      return null;
    }
  }

  // 请求装备图鉴数据
  static Future<List<dynamic>?> getEquipment() async {
    try {
      final response = await CommonRequest.dio.get('/equipment/all');
      return response.data;
    } catch (err) {
      CommonLogger.error(err);
      return null;
    }
  }

  // 请求英雄图鉴数据
  static Future<List<dynamic>?> getHero() async {
    try {
      final response = await CommonRequest.dio.get('/hero/all');
      return response.data;
    } catch (err) {
      CommonLogger.error(err);
      return null;
    }
  }
}
