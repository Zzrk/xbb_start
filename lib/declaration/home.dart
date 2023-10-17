class CalendarInfo {
  final String title;
  final DateTime beginTime;
  final DateTime endTime;
  final String description;

  const CalendarInfo({
    required this.title,
    required this.beginTime,
    required this.endTime,
    required this.description,
  });

  factory CalendarInfo.fromJson(Map<String, dynamic> json) {
    return CalendarInfo(
      title: json['title'],
      beginTime: DateTime.parse(json['begin_time']),
      endTime: DateTime.parse(json['end_time']),
      description: json['description'],
    );
  }

  static List<CalendarInfo> parseCalendarData(List<dynamic> responseBody) {
    final parsed = responseBody.cast<Map<String, dynamic>>();
    return parsed.map<CalendarInfo>((json) => CalendarInfo.fromJson(json)).toList();
  }
}