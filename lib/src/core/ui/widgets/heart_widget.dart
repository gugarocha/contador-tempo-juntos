import 'package:flutter/material.dart';

import '../constants.dart';

class HeartWidget extends StatelessWidget {
  const HeartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Icon(
        Icons.favorite_outline,
        color: ColorsConstants.secondary,
      ),
    );
  }
}
