import 'package:flutter/material.dart';

// 装备品质列表
const equipmentQualityList = ['白', '绿', '蓝', '紫'];

// 英雄类型映射
const heroTypeMap = {'力': 'hero_str', '敏': 'hero_agi', '智': 'hero_int'};

// 装备品质映射
const equipmentQualityMap = {
  '白': 'white',
  '绿': 'green',
  '蓝': 'blue',
  '紫': 'purple'
};

// 英雄阶段列表
const heroStageList = ['蓝+2', '紫', '紫+1', '紫+2', '紫+3'];

// 英雄阶段选择列表
final dropdownItems = heroStageList
    .map((e) => DropdownMenuItem(
          value: e,
          child: Text(e),
        ))
    .toList();
