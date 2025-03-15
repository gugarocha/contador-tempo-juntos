import 'package:flutter/material.dart';

import '../../core/utils/util_functions.dart';
import '../best_moments/best_moments_page.dart';

class TakeMomentPage extends StatelessWidget {
  const TakeMomentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Que tal registrar um momento agora?'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () =>
              UtilFunctions.navigateTo(context, const BestMomentsPage()),
          child: const Text('Registrar momento'),
        ),
      ),
    );
  }
}
