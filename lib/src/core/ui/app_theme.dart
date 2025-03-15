import 'package:flutter/material.dart';

import 'constants.dart';

sealed class AppTheme {
  static ThemeData themeData = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorsConstants.primary,
      surface: ColorsConstants.background,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: ColorsConstants.primary),
    ),
  );
}
