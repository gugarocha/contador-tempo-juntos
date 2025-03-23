import 'package:flutter/material.dart';

import '../constants.dart';

class CircularIcon extends Icon {
  const CircularIcon(
    super.icon, {
    this.containerSize = 80,
    super.size,
    super.key,
  });

  final double containerSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: containerSize,
      height: containerSize,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(224, 170, 255, 0.2),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: super.size ?? 45,
        color: ColorsConstants.primary,
      ),
    );
  }
}
