import 'package:flutter/cupertino.dart';

sealed class UtilFunctions {
  static void navigateTo(BuildContext context, Widget page) {
    Navigator.of(context).pushReplacement(
      CupertinoPageRoute(
        builder: (ctx) => page,
      ),
    );
  }
}
