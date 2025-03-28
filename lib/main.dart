import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:flutter/material.dart';
import 'src/core/env/env.dart';
import 'src/core/ui/app_theme.dart';
import 'src/pages/safe/safe_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Env.instance.load();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MaterialApp(
      title: 'Contador de Tempo Juntos',
      debugShowCheckedModeBanner: false,
      home: const SafePage(),
      theme: AppTheme.themeData,
    ),
  );
}
