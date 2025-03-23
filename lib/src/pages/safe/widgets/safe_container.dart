import 'package:flutter/material.dart';

class SafeContainer extends StatelessWidget {
  final Widget child;

  const SafeContainer({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black26,
        border: Border.all(color: Colors.grey, width: 0.5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: child,
    );
  }
}
