// 我的装备(碎片)
class MyEquipment {
  final int id;
  final String name;
  int count;

  MyEquipment({required this.id, required this.name, required this.count});

  factory MyEquipment.fromJson(Map<String, dynamic> json) {
    return MyEquipment(id: json['id'], name: json['name'], count: json['count']);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> all = {};
    all["id"] = id;
    all["name"] = name;
    all["count"] = count;
    return {
      "id": id,
      "name": name,
      "count": count,
    };
  }
}

List<MyEquipment> parseMyEquipmentList(List<dynamic> responseBody) {
  final parsed = responseBody.cast<Map<String, dynamic>>();
  return parsed.map<MyEquipment>((json) => MyEquipment.fromJson(json)).toList();
}
