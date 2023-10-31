import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xbb_start/declaration/hero.dart';
import 'package:xbb_start/declaration/index.dart';

// 装备图片
class HeroImage extends StatelessWidget {
  const HeroImage({
    super.key,
    required this.hero,
    required this.imageSize,
  });

  final HeroInfo hero;
  final double imageSize;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: hero.name,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(imageSize * 0.2),
            child: Image.network(
              '$heroBaseUrl/${hero.name}.jpg',
              width: imageSize,
              height: imageSize,
            ),
          ),
          Positioned(
            left: -imageSize * 0.1,
            top: -imageSize * 0.11,
            child: Image.asset(
              'assets/hero_detail/hero_icon_frame_1.png',
              width: imageSize * 1.2,
              height: imageSize * 1.2,
            ),
          )
        ],
      ),
    );
  }
}

// 英雄项
class HeroItem extends StatelessWidget {
  const HeroItem({
    super.key,
    required this.hero,
    this.imageSize = 32,
    this.fontSize = 12,
    this.outerPadding = const EdgeInsets.only(top: 8.0),
    this.innerPadding = const EdgeInsets.all(12.0),
    this.onTap,
    this.decoration,
  });

  final HeroInfo hero;
  final double imageSize;
  final double fontSize;
  final EdgeInsets outerPadding;
  final EdgeInsets innerPadding;
  final void Function()? onTap;
  final BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    final heroName = hero.name;
    final isTodo = hero.stages.any((stage) => stage.equipments.any((equipment) => equipment.isEmpty));

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (onTap != null) {
          onTap!();
          return;
        }
        Get.toNamed('/hero_detail', arguments: hero);
      },
      child: Container(
        decoration: decoration,
        child: Padding(
          padding: outerPadding,
          child: Column(
            children: [
              Padding(
                padding: innerPadding,
                child: HeroImage(
                  hero: hero,
                  imageSize: imageSize,
                ),
              ),
              Text(
                heroName + (isTodo ? '*' : ''),
                style: TextStyle(fontSize: fontSize),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
