import 'package:flutter/material.dart';

class SafeContainer extends StatelessWidget {
  final Widget child;

  const SafeContainer({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 550,
      padding: const EdgeInsets.symmetric(vertical: 32),
      decoration: const BoxDecoration(
        color: Color(0xFF343a40),
      ),
      child: child,
    );
  }
}
