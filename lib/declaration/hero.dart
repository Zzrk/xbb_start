import 'dart:convert';

class HeroStage {
  // 英雄阶段 白/绿/蓝/蓝+1/蓝+2/紫/紫+1/紫+2/紫+3
  final String stage;
  // 阶段装备
  final List<String> equipments;
  // 可进阶等级
  final int? level;

  const HeroStage({
    required this.stage,
    required this.equipments,
    this.level,
  });

  factory HeroStage.fromJson(Map<String, dynamic> json) {
    final level = json['level'];
    return HeroStage(
      stage: json['stage'] as String,
      equipments: json['equipments'].cast<String>(),
      level: level != null ? level as int : null,
    );
  }
}

class HeroInfo {
  // 英雄名称
  final String name;
  // 英雄类型 力/敏/智
  final String type;
  // 英雄初始星级
  final int star;
  // 英雄阶段
  final List<HeroStage> stages;

  const HeroInfo({
    required this.name,
    required this.type,
    required this.star,
    required this.stages,
  });

  factory HeroInfo.fromJson(Map<String, dynamic> json) {
    return HeroInfo(
      name: json['name'] as String,
      type: json['type'] as String,
      star: json['star'] as int,
      stages: json['stages']
          .map((x) => HeroStage.fromJson(x))
          .toList()
          .cast<HeroStage>(),
    );
  }
}

List<HeroInfo> parseHeroList(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<HeroInfo>((json) => HeroInfo.fromJson(json)).toList();
}

class HeroFosterInfo {
  // 养成的英雄
  final HeroInfo hero;
  // 初始阶段
  String from;
  // 初始状态
  int fromState;
  // 目的阶段
  String to;
  // 目的状态
  int toState;

  HeroFosterInfo({
    required this.hero,
    required this.from,
    required this.to,
    this.fromState = 0,
    this.toState = 63,
  });
}
