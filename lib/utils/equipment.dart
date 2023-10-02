import 'package:flutter/material.dart';

abstract class EquipmentItem {
  const EquipmentItem(
      {required this.name,
      this.access,
      this.description = '',
      this.image = const AssetImage('assets/equipment/placeholder.png')});

  // 装备名称
  final String name;
  // 获取途径
  final List<String>? access;
  // 装备描述
  final String description;
  // 装备图片
  final AssetImage image;
}

class Equipment extends EquipmentItem {
  const Equipment(
      {required super.name, super.access, super.description, super.image});
}

class EquipmentFragment extends EquipmentItem {
  const EquipmentFragment(
      {required super.name, super.access, super.description, super.image});
}
