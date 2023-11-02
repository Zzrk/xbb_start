import 'package:get/get.dart';
import 'package:xbb_start/declaration/home.dart';
import 'package:xbb_start/utils/request.dart';
import 'package:xbb_start/utils/storage.dart';

class HomeController extends GetxController {
  // 当前控制器实例
  static HomeController get to => Get.find();
  // 本地存储
  var storage = HomeStorage();

  // ------------------- 活动日历 -------------------
  // 活动日历数据
  var calendarData = <CalendarInfo>[].obs;
  // 今日活动数据
  var currentActivity = <CalendarInfo>[].obs;

  // 设置活动日历数据
  void setCalendarData(List<CalendarInfo> list) {
    calendarData.value = list;
    currentActivity.value = list.where((element) {
      final now = DateTime.now();
      final beginTime = element.beginTime;
      final endTime = element.endTime;
      return now.isAfter(beginTime) && now.isBefore(endTime);
    }).toList();
  }

  // 从本地存储中恢复活动日历数据
  Future<void> recoverCalendarData() async {
    final list = CalendarInfo.parseCalendarData(await storage.readCalendar());
    setCalendarData(list);
  }

  // 重新请求活动日历数据
  Future<bool> reRequestCalendarData() async {
    final list = CalendarInfo.parseCalendarData(await CommonRequest.getCalendarData() ?? []);
    if (list.isEmpty) return false;
    setCalendarData(list);
    storage.writeCalendar(list);
    return true;
  }

  // 初始化活动日历数据
  Future<void> initCalendarData() async {
    await recoverCalendarData();
    await reRequestCalendarData();
  }

  // ------------------- 兑换码 -------------------
  // 兑换码数据
  var redeemCode = <RedeemCode>[].obs;

  // 从本地存储中恢复兑换码数据
  Future<void> recoverRedeemCode() async {
    final list = RedeemCode.parseRedeemCode(await storage.readCode());
    redeemCode.value = list;
  }

  // 重新请求兑换码数据
  Future<bool> reRequestRedeemCode() async {
    final list = RedeemCode.parseRedeemCode(await CommonRequest.getRedeemCode() ?? []);
    if (list.isEmpty) return false;
    redeemCode.value = list;
    storage.writeCode(list);
    return true;
  }

  // 初始化兑换码数据
  Future<void> initRedeemCode() async {
    await recoverRedeemCode();
    await reRequestRedeemCode();
  }

  // ------------------- 初始化 -------------------
  var isInit = false.obs;

  Future<List<void>> recoverFromStorage() async {
    return Future.wait([
      recoverCalendarData(),
      recoverRedeemCode(),
    ]);
  }

  Future<bool> reRequest() async {
    final results = await Future.wait([
      reRequestCalendarData(),
      reRequestRedeemCode(),
    ]);
    return results.every((element) => element);
  }
}
