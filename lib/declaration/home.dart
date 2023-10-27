class CalendarInfo {
  final String title;
  final DateTime beginTime;
  final DateTime endTime;
  final List<String> description;

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
      description: json['description'].cast<String>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "begin_time": beginTime.toString(),
      "end_time": endTime.toString(),
      "description": description,
    };
  }

  static List<CalendarInfo> parseCalendarData(List<dynamic> responseBody) {
    final parsed = responseBody.cast<Map<String, dynamic>>();
    return parsed.map<CalendarInfo>((json) => CalendarInfo.fromJson(json)).toList();
  }
}

class RedeemCode {
  final String code;
  final String desc;

  const RedeemCode({
    required this.code,
    required this.desc,
  });

  factory RedeemCode.fromJson(Map<String, dynamic> json) {
    return RedeemCode(
      code: json['code'],
      desc: json['desc'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "code": code,
      "desc": desc,
    };
  }

  static List<RedeemCode> parseRedeemCode(List<dynamic> responseBody) {
    final parsed = responseBody.cast<Map<String, dynamic>>();
    return parsed.map<RedeemCode>((json) => RedeemCode.fromJson(json)).toList();
  }
}
