import 'package:flutter/material.dart';

class KeyboardItem extends StatelessWidget {
  final String char;
  final void Function() onPressed;

  const KeyboardItem({required this.char, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Center(
        child: Text(
          char,
          style: const TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
