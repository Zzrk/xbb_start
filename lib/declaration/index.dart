import 'package:flutter/material.dart';

// 装备品质列表
const equipmentQualityList = ['白', '绿', '蓝', '紫', '橙'];

// 装备品质映射
const equipmentQualityMap = {'白': 'white', '绿': 'green', '蓝': 'blue', '紫': 'purple', '橙': 'orange'};

// 英雄星级列表
const heroStarList = ['一星', '二星', '三星'];

// 英雄类型列表
const heroTypeList = ['力', '敏', '智'];

// 英雄类型映射
const heroTypeMap = {'力': 'hero_str', '敏': 'hero_agi', '智': 'hero_int'};

// 英雄阶段列表
const heroStageList = ['蓝+2', '紫', '紫+1', '紫+2', '紫+3', '紫+4'];

// 英雄阶段选择列表
final dropdownItems = heroStageList
    .map((e) => DropdownMenuItem(
          value: e,
          child: Text(e),
        ))
    .toList();

// 星期列表
const weekList = ['一', '二', '三', '四', '五', '六', '日'];
