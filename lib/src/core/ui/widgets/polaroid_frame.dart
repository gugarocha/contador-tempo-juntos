import 'package:flutter/material.dart';

class PolaroidFrame extends StatelessWidget {
  const PolaroidFrame({
    required this.child,
    this.frameWidth = 267,
    this.frameHeight = 324,
    this.imageWidth = 240,
    this.imageHeight = 240,
    this.marginTop = 13,
    this.imageDate,
    super.key,
  });

  final Widget child;
  final double frameWidth;
  final double frameHeight;
  final double imageWidth;
  final double imageHeight;
  final double marginTop;
  final String? imageDate;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: frameWidth,
          height: frameHeight,
          color: Colors.white,
        ),
        Positioned(
          top: marginTop,
          child: Container(
            width: imageWidth,
            height: imageHeight,
            color: Colors.black,
            child: child,
          ),
        ),
        Positioned(
          bottom: 15,
          child: Text(
            imageDate ?? '',
            style: const TextStyle(
              fontFamily: 'Kalam',
              fontSize: 24,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
