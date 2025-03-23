import 'package:flutter/material.dart';

class ContentContainer extends StatelessWidget {
  final Widget child;

  const ContentContainer({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FittedBox(
        child: Container(
          width: 350,
          padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black26,
            border: Border.all(color: Colors.grey, width: 0.5),
            borderRadius: BorderRadius.circular(15),
          ),
          child: child,
        ),
      ),
    );
  }
}
