import 'package:flutter/material.dart';

class PriorityImage extends StatelessWidget {
  final String localImage;
  final String networkImage;
  final double width;
  final double height;
  final Color? color;
  final BlendMode? colorBlendMode;

  const PriorityImage({
    required this.localImage,
    required this.networkImage,
    required this.width,
    required this.height,
    this.color,
    this.colorBlendMode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      localImage,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      errorBuilder: (context, error, stackTrace) {
        print('error');
        return Image.network(
          networkImage,
          width: width,
          height: height,
          color: color,
          colorBlendMode: colorBlendMode,
        );
      },
    );
  }
}
