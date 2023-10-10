import 'dart:convert';

class MyEquipment {
  final String name;
  final int count;

  const MyEquipment({required this.name, required this.count});

  factory MyEquipment.fromJson(Map<String, dynamic> json) {
    return MyEquipment(name: json['name'], count: json['count']);
  }
}

List<MyEquipment> parseMyEquipmentList(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<MyEquipment>((json) => MyEquipment.fromJson(json)).toList();
}
