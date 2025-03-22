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
}
