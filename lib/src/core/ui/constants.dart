import 'package:flutter/material.dart';

sealed class ColorsConstants {
  static const background = Color(0xFF10002b);
  static const primary = Color(0xFFE0AAFF);
  static const secondary = Color(0xFFFF4E6D);
}

sealed class ImagesConstants {
  static const loading = 'assets/images/loading_hearts.gif';
}

sealed class FontsConstants {
  static const titleFontFamily = 'PlayfairDisplay';

  static const titleMedium = TextStyle(
    fontFamily: titleFontFamily,
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 28,
  );
  static const bodySmall = TextStyle(
    color: Colors.grey,
    fontWeight: FontWeight.w200,
    fontSize: 16,
  );
}
