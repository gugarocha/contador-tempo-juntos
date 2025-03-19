import 'package:flutter/material.dart';

class PolaroidFrame extends StatelessWidget {
  const PolaroidFrame({
    required this.child,
    this.frameWidth = 267,
    this.frameHeight = 324,
    this.imageWidth = 240,
    this.imageHeight = 240,
    this.marginTop = 13,
    super.key,
  });

  final Widget child;
  final double frameWidth;
  final double frameHeight;
  final double imageWidth;
  final double imageHeight;
  final double marginTop;

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
        const Positioned(
          bottom: 5,
          child: Text(
            '24/12/2024',
            style: TextStyle(
              fontFamily: 'Kalam',
              fontSize: 36,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
