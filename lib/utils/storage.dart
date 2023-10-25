import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class MyEquipmentStorage {
  // 本地存储路径
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // 我的装备数据文件
  Future<File> get _itemFile async {
    final path = await _localPath;
    return File('$path/item.json');
  }

  // 我的碎片数据文件
  Future<File> get _fragmentFile async {
    final path = await _localPath;
    return File('$path/fragment.json');
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
