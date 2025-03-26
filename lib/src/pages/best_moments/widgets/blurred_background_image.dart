import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../core/ui/widgets/heart_widget.dart';

class BlurredBackgroundImage extends StatelessWidget {
  const BlurredBackgroundImage({
    required this.image,
    this.imageDate = '',
    super.key,
  });

  final ImageProvider image;
  final String imageDate;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Image(image: image, fit: BoxFit.cover),
        ),
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image(
              image: image,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Positioned(
          bottom: 30,
          left: 10,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                const HeartWidget(),
                const SizedBox(width: 5),
                Text(
                  imageDate,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
