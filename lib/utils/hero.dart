import 'dart:convert';

class HeroStage {
  // 英雄阶段 白/绿/蓝/蓝+1/蓝+2/紫/紫+1/紫+2/紫+3
  final String stage;
  // 阶段装备
  final List<String> equipments;
  // 可进阶等级
  final int level;

  const HeroStage({
    required this.stage,
    required this.equipments,
    required this.level,
  });

  factory HeroStage.fromJson(Map<String, dynamic> json) {
    return HeroStage(
      stage: json['stage'] as String,
      equipments: json['equipments'].cast<String>(),
      level: json['level'] as int,
    );
  }
}

class Hero {
  // 英雄名称
  final String name;
  // 英雄类型 力/敏/智
  final String type;
  // 英雄初始星级
  final int star;
  // 英雄阶段
  final List<HeroStage> stages;

  const Hero({
    required this.name,
    required this.type,
    required this.star,
    required this.stages,
  });

  factory Hero.fromJson(Map<String, dynamic> json) {
    return Hero(
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

List<Hero> parseHeroList(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Hero>((json) => Hero.fromJson(json)).toList();
}
