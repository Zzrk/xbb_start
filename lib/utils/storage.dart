import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class HomeStorage {
  // 本地存储路径
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // 活动日历数据文件
  Future<File> get _calendarFile async {
    final path = await _localPath;
    return File('$path/calendar.json');
  }

  // 兑换码数据文件
  Future<File> get _codeFile async {
    final path = await _localPath;
    return File('$path/code.json');
  }

  // 读取活动日历数据
  Future<List<dynamic>> readCalendar() async {
    try {
      final file = await _calendarFile;
      final calendarData = await file.readAsString();
      return jsonDecode(calendarData);
    } catch (e) {
      return [];
    }
  }

  // 写入活动日历数据
  Future<File> writeCalendar(List<dynamic> calendarData) async {
    final file = await _calendarFile;
    return file.writeAsString(jsonEncode(calendarData));
  }

  // 读取兑换码数据
  Future<List<dynamic>> readCode() async {
    try {
      final file = await _codeFile;
      final codeData = await file.readAsString();
      return jsonDecode(codeData);
    } catch (e) {
      return [];
    }
  }

  // 写入兑换码数据
  Future<File> writeCode(List<dynamic> codeData) async {
    final file = await _codeFile;
    return file.writeAsString(jsonEncode(codeData));
  }
}

class EquipmentStorage {
  // 本地存储路径
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // 装备图鉴文件
  Future<File> get _equipmentFile async {
    final path = await _localPath;
    return File('$path/equipment.json');
  }

  // 读取装备数据
  Future<List<dynamic>> readEquipment() async {
    try {
      final file = await _equipmentFile;
      final equipments = await file.readAsString();
      return jsonDecode(equipments);
    } catch (e) {
      return [];
    }
  }

  // 写入装备数据
  Future<File> writeEquipment(List<dynamic> equipments) async {
    final file = await _equipmentFile;
    return file.writeAsString(jsonEncode(equipments));
  }
}

class HeroStorage {
  // 本地存储路径
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // 英雄图鉴文件
  Future<File> get _heroFile async {
    final path = await _localPath;
    return File('$path/hero.json');
  }

  // 读取英雄数据
  Future<List<dynamic>> readHero() async {
    try {
      final file = await _heroFile;
      final heroes = await file.readAsString();
      return jsonDecode(heroes);
    } catch (e) {
      return [];
    }
  }

  // 写入英雄数据
  Future<File> writeHero(List<dynamic> heroes) async {
    final file = await _heroFile;
    return file.writeAsString(jsonEncode(heroes));
  }
}

class MyEquipmentStorage {
  // 本地存储路径
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // 我的装备数据文件
  Future<File> get _itemFile async {
    final path = await _localPath;
    return File('$path/myEquipment.json');
  }

  // 我的碎片数据文件
  Future<File> get _fragmentFile async {
    final path = await _localPath;
    return File('$path/myFragment.json');
  }

  // 读取装备数据
  Future<List<dynamic>> _readItem() async {
    try {
      final file = await _itemFile;
      final equipments = await file.readAsString();
      return jsonDecode(equipments);
    } catch (e) {
      return [];
    }
  }

  // 写入装备数据
  Future<File> _writeItem(List<dynamic> equipments) async {
    final file = await _itemFile;
    return file.writeAsString(jsonEncode(equipments));
  }

  // 读取碎片数据
  Future<List<dynamic>> _readFragment() async {
    try {
      final file = await _fragmentFile;
      final equipments = await file.readAsString();
      return jsonDecode(equipments);
    } catch (e) {
      return [];
    }
  }

  // 写入碎片数据
  Future<File> _writeFragment(List<dynamic> equipments) async {
    final file = await _fragmentFile;
    return file.writeAsString(jsonEncode(equipments));
  }

  // 读取数据
  Future<List<dynamic>> readEquipment(String type) async {
    return type == 'item' ? _readItem() : _readFragment();
  }

  // 写入数据
  Future<File> writeEquipment(String type, List<dynamic> equipments) async {
    return type == 'item' ? _writeItem(equipments) : _writeFragment(equipments);
  }
}
