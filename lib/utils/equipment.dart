import 'dart:convert';
import 'package:flutter/material.dart';

// 装备品质
// const equipmentQualityMap = {

// const equipmentQualityMap = {
//   EquipmentQuality.white: '白',
//   EquipmentQuality.green: '绿',
//   EquipmentQuality.blue: '蓝',
//   EquipmentQuality.purple: '紫',
// };

abstract class EquipmentItem {
  const EquipmentItem(
      {required this.name,
      required this.quality,
      this.access,
      required this.description,
      this.image = const AssetImage('assets/equipment/placeholder.png')});

  // 装备名称
  final String name;
  // 装备品质
  final String quality;
  // 获取途径
  final List<String>? access;
  // 装备描述
  final String description;
  // 装备图片
  final AssetImage image;
}

class Equipment extends EquipmentItem {
  const Equipment(
      {required super.name,
      required super.quality,
      super.access,
      required super.description,
      super.image});

  factory Equipment.fromJson(Map<String, dynamic> json) {
    final access = json['access'];
    return Equipment(
      name: json['name'] as String,
      quality: json['quality'] as String,
      description: json['description'] as String,
      access: access != null ? List<String>.from(access) : null,
    );
  }
}

List<Equipment> parseEquipmentList(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  // print('类型: ${parsed[10]['access'].runtimeType}');
  return parsed.map<Equipment>((json) => Equipment.fromJson(json)).toList();
}

class EquipmentFragment extends EquipmentItem {
  const EquipmentFragment(
      {required super.name,
      required super.quality,
      super.access,
      required super.description,
      super.image});

  factory EquipmentFragment.fromJson(Map<String, dynamic> json) {
    return EquipmentFragment(
      name: json['name'] as String,
      quality: json['quality'] as String,
      description: json['description'] as String,
      access: json['access'] as List<String>,
    );
  }
}
