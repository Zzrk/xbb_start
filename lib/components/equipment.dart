import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xbb_start/declaration/equipment.dart';
import 'package:xbb_start/declaration/index.dart';

// 装备碎片的裁剪器
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
class EquipmentImage extends StatelessWidget {
  const EquipmentImage({
    super.key,
    required this.equipment,
    required this.imageSize,
    this.isGrey = false,
    this.tagPrefix = '',
  });

  final Equipment equipment;
  final double imageSize;
  final bool isGrey;
  final String tagPrefix;

  @override
  Widget build(BuildContext context) {
    final equipmentName = equipment.name.replaceAll('(碎片)', '');
    final equipmentQuality = equipmentQualityMap[equipment.quality]!;
    final isFragment = equipment.category == 'fragment';

    if (isFragment) {
      return Hero(
        tag: tagPrefix + equipment.name,
        child: Stack(
          children: [
            ClipPath(
              clipper: MyClipper(),
              child: Image.network(
                '$equipmentBaseUrl/$equipmentName.jpg',
                width: imageSize,
                height: imageSize,
              ),
            ),
            Positioned(
              left: -imageSize * 0.1,
              top: -imageSize * 0.1,
              child: Image.asset(
                'assets/equipment_detail/fragment_frame_$equipmentQuality.png',
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
        tag: tagPrefix + equipment.name,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(imageSize * 0.2),
              child: Image.network(
                '$equipmentBaseUrl/$equipmentName.jpg',
                width: imageSize,
                height: imageSize,
                color: isGrey ? Colors.grey : null,
                colorBlendMode: isGrey ? BlendMode.color : null,
              ),
            ),
            Positioned(
              left: -imageSize * 0.1,
              top: -imageSize * 0.1,
              child: Image.asset(
                'assets/equipment_detail/equip_frame_$equipmentQuality.png',
                width: imageSize * 1.2,
                height: imageSize * 1.2,
                color: isGrey ? Colors.grey : null,
              ),
            )
          ],
        ),
      );
    }
  }
}

// 装备项
class EquipmentItem extends StatelessWidget {
  const EquipmentItem({
    super.key,
    required this.equipment,
    this.imageSize = 32,
    this.fontSize = 12,
    this.outerPadding = const EdgeInsets.only(top: 8.0),
    this.innerPadding = const EdgeInsets.all(12.0),
    this.count,
    this.onLongPress,
    this.tagPrefix = '',
  });

  final Equipment equipment;
  final double imageSize;
  final double fontSize;
  final EdgeInsets outerPadding;
  final EdgeInsets innerPadding;
  final int? count;
  final void Function()? onLongPress;
  final String tagPrefix;

  @override
  Widget build(BuildContext context) {
    final equipmentName = equipment.name;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        // 跳转到装备详情页
        Get.toNamed(
          '/equipment_detail?name=$equipmentName',
          arguments: equipment,
        );
      },
      onLongPress: onLongPress,
      child: Padding(
        padding: outerPadding,
        child: Column(
          children: [
            Padding(
              padding: innerPadding,
              child: EquipmentImage(
                equipment: equipment,
                imageSize: imageSize,
                tagPrefix: tagPrefix,
              ),
            ),
            Text(
              equipmentName.replaceAll('(碎片)', ''),
              style: TextStyle(fontSize: fontSize),
            ),
            if (count != null) Text('x$count')
          ],
        ),
      ),
    );
  }
}
