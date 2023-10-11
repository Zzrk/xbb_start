class MyEquipment {
  final int id;
  final String name;
  int count;

  MyEquipment({required this.id, required this.name, required this.count});

  factory MyEquipment.fromJson(Map<String, dynamic> json) {
    return MyEquipment(
        id: json['id'], name: json['name'], count: json['count']);
  }
}

List<MyEquipment> parseMyEquipmentList(List<dynamic> responseBody) {
  final parsed = responseBody.cast<Map<String, dynamic>>();
  return parsed.map<MyEquipment>((json) => MyEquipment.fromJson(json)).toList();
}
