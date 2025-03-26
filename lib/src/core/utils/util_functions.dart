import 'package:flutter/cupertino.dart';

sealed class UtilFunctions {
  static void navigateTo(
    BuildContext context,
    Widget page, {
    bool pushReplacement = true,
  }) {
    pushReplacement
        ? Navigator.of(context).pushReplacement(
            CupertinoPageRoute(
              builder: (ctx) => page,
            ),
          )
        : Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (ctx) => page,
            ),
          );
  }

  static String getMonthFromNumber(int month) {
    final months = [
      'Janeiro',
      'Fevereiro',
      'Março',
      'Abril',
      'Maio',
      'Junho',
      'Julho',
      'Agosto',
      'Setembro',
      'Outubro',
      'Novembro',
      'Dezembro',
    ];

    return months[month - 1];
  }
}
