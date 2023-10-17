import 'package:get/get.dart';
import 'package:xbb_start/declaration/home.dart';
import 'package:xbb_start/utils/request.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  // 活动日历数据
  var calendarData = <CalendarInfo>[].obs;
  // 今日活动数据
  var currentActivity = <CalendarInfo>[].obs;

  // 初始化活动日历数据
  Future<void> initCalendarData() async {
    final response = await CommonRequest.getCalendarData();
    final list = CalendarInfo.parseCalendarData(response);
    calendarData.value = list;
    currentActivity.value = list.where((element) {
      final now = DateTime.now();
      final beginTime = element.beginTime;
      final endTime = element.endTime;
      return now.isAfter(beginTime) && now.isBefore(endTime);
    }).toList();
  }
}
