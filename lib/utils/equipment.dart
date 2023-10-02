import 'package:flutter/material.dart';

// 装备品质
enum EquipmentQuality { white, green, blue, purple }

const equipmentQualityMap = {
  EquipmentQuality.white: '白',
  EquipmentQuality.green: '绿',
  EquipmentQuality.blue: '蓝',
  EquipmentQuality.purple: '紫',
};

abstract class EquipmentItem {
  const EquipmentItem(
      {required this.name,
      required this.quality,
      this.access,
      this.description = '',
      this.image = const AssetImage('assets/equipment/placeholder.png')});

  // 装备名称
  final String name;
  // 装备品质
  final EquipmentQuality quality;
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
      super.description,
      super.image});
}

class EquipmentFragment extends EquipmentItem {
  const EquipmentFragment(
      {required super.name,
      required super.quality,
      super.access,
      super.description,
      super.image});
}
