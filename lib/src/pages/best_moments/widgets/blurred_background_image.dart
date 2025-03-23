import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../core/ui/widgets/heart_widget.dart';

class BlurredBackgroundImage extends StatelessWidget {
  const BlurredBackgroundImage(this.image, {super.key});

  final ImageProvider image;

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
            child: const Row(
              children: [
                HeartWidget(),
                SizedBox(width: 5),
                Text(
                  '26 de Março, 2021',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
