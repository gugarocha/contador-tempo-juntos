import 'package:flutter/material.dart';

import '../../../core/env/env.dart';
import '../../../core/ui/widgets/polaroid_frame.dart';

final String imageUrl = Env.instance.get('polaroid_image');

class PolaroidImage extends StatefulWidget {
  const PolaroidImage({super.key});

  @override
  State<PolaroidImage> createState() => _PolaroidImageState();
}

class _PolaroidImageState extends State<PolaroidImage> {
  double _opacity = 0.0;

  void _startRevealEffect() {
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PolaroidFrame(
      child: Image.network(
        imageUrl,
        width: 240,
        height: 240,
        fit: BoxFit.fitWidth,
        alignment: Alignment.topCenter,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            _startRevealEffect();
          }
          return AnimatedOpacity(
            duration: const Duration(seconds: 6),
            curve: Curves.linear,
            opacity: _opacity,
            child: child,
          );
        },
      ),
    );
  }
}
