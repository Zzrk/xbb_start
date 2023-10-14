// 补齐两位数字
String fillZero(int num) {
  return num < 10 ? '0$num' : '$num';
}

// 时间格式化
String formatTime(DateTime time) {
  return '${fillZero(time.month)}月${fillZero(time.day)}日 ${fillZero(time.hour)}:${fillZero(time.minute)}';
}

// 通用时间间隔
String formatDuration(DateTime beginTime, DateTime endTime) {
  final localBeginTime = beginTime.add(const Duration(hours: 8));
  final localEndTime = endTime.add(const Duration(hours: 8));
  return '${formatTime(localBeginTime)} - ${formatTime(localEndTime)}';
}
