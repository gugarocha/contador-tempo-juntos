import 'package:flutter/material.dart';

class KeyboardItem extends StatelessWidget {
  final String char;
  final void Function() onPressed;

  const KeyboardItem({required this.char, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      decoration: BoxDecoration(
        color: Colors.black26,
        border: Border.all(
          color: Colors.grey,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: InkWell(
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
      ),
    );
  }
}
