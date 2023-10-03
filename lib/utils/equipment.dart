import 'dart:convert';

// 装备品质
// const equipmentQualityMap = {

// const equipmentQualityMap = {
//   EquipmentQuality.white: '白',
//   EquipmentQuality.green: '绿',
//   EquipmentQuality.blue: '蓝',
//   EquipmentQuality.purple: '紫',
// };

abstract class Equipment {
  const Equipment({
    required this.type,
    required this.name,
    required this.quality,
    this.access,
    required this.description,
  });

  // 装备类型 item/fragment
  final String type;
  // 装备名称
  final String name;
  // 装备品质 白/绿/蓝/紫
  final String quality;
  // 获取途径
  final List<String>? access;
  // 装备描述
  final String description;
}

class EquipmentItem extends Equipment {
  const EquipmentItem({
    required super.type,
    required super.name,
    required super.quality,
    super.access,
    required super.description,
  });

  factory EquipmentItem.fromJson(Map<String, dynamic> json) {
    final access = json['access'];
    return EquipmentItem(
      type: json['type'] as String,
      name: json['name'] as String,
      quality: json['quality'] as String,
      description: json['description'] as String,
      access: access != null ? List<String>.from(access) : null,
    );
  }
}

List<EquipmentItem> parseEquipmentList(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed
      .map<EquipmentItem>((json) => EquipmentItem.fromJson(json))
      .toList();
}
