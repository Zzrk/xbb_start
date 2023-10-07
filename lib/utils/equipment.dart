import 'dart:convert';

class EquipmentSynthesis {
  // 装备名称
  final String name;
  // 装备数量
  final int count;

  const EquipmentSynthesis({
    required this.name,
    required this.count,
  });

  factory EquipmentSynthesis.fromJson(Map<String, dynamic> json) {
    return EquipmentSynthesis(
      name: json['name'] as String,
      count: json['count'] as int,
    );
  }
}

class Equipment {
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
  // 装备合成
  final List<EquipmentSynthesis>? synthesis;
  // 需求等级
  final int? level;

  const Equipment({
    required this.type,
    required this.name,
    required this.quality,
    this.access,
    required this.description,
    this.synthesis,
    this.level,
  });

  factory Equipment.fromJson(Map<String, dynamic> json) {
    final access = json['access'];
    final synthesis = json['synthesis'];
    return Equipment(
      type: json['type'] as String,
      name: json['name'] as String,
      quality: json['quality'] as String,
      description: json['description'] as String,
      access: access != null ? access!.cast<String>() : null,
      synthesis: synthesis != null
          ? synthesis!
              .map((x) => EquipmentSynthesis.fromJson(x))
              .toList()
              .cast<EquipmentSynthesis>()
          : null,
      level: json['level'],
    );
  }
}

List<Equipment> parseEquipmentList(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Equipment>((json) => Equipment.fromJson(json)).toList();
}

class EquipmentFoster {
  final Equipment equipment;
  int count;

  EquipmentFoster({required this.equipment, required this.count});
}
