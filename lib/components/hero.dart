import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xbb_start/declaration/hero.dart';
import 'package:xbb_start/declaration/index.dart';

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(size.width - size.width * 0.24, 0)
      ..lineTo(size.width, size.height * 0.24)
      ..lineTo(size.width, size.height - size.height * 0.14)
      ..lineTo(size.width - size.width * 0.14, size.height)
      ..lineTo(size.width * 0.24, size.height)
      ..lineTo(0, size.height - size.height * 0.24)
      ..lineTo(0, size.height * 0.14)
      ..lineTo(size.width * 0.14, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// 装备图片
class HeroImage extends StatelessWidget {
  const HeroImage({
    super.key,
    required this.hero,
    required this.imageSize,
    this.isFragment = false,
  });

  final HeroInfo hero;
  final double imageSize;
  final bool isFragment;

  @override
  Widget build(BuildContext context) {
    final quality = heroQualityMap[hero.star];

    if (isFragment) {
      return Hero(
        tag: hero.name,
        child: Stack(
          children: [
            ClipPath(
              clipper: MyClipper(),
              child: Image.network(
                '$heroBaseUrl/${hero.name}.jpg',
                width: imageSize,
                height: imageSize,
              ),
            ),
            Positioned(
              left: -imageSize * 0.1,
              top: -imageSize * 0.1,
              child: Image.asset(
                'assets/equipment_detail/fragment_frame_$quality.png',
                width: imageSize * 1.2,
                height: imageSize * 1.2,
              ),
            ),
            Positioned(
              left: imageSize * 0.04,
              top: imageSize * 0.04,
              child: Image.asset(
                'assets/equipment_detail/fragment_tag.png',
                width: imageSize * 0.24,
                height: imageSize * 0.24,
              ),
            ),
          ],
        ),
      );
    } else {
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
              top: -imageSize * 0.1,
              child: Image.asset(
                'assets/equipment_detail/equip_frame_$quality.png',
                width: imageSize * 1.2,
                height: imageSize * 1.2,
              ),
            ),
          ],
        ),
      );
    }
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
