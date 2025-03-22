import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:flutter/material.dart';
import 'src/core/env/env.dart';
import 'src/core/ui/app_theme.dart';
import 'src/pages/best_moments/best_moments_page.dart';
import 'src/pages/camera/camera_page.dart';
import 'src/pages/count_time/count_time_page.dart';
import 'src/pages/safe/safe_page.dart';
import 'src/pages/take_moment/take_moment_page.dart';

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
      // home: const Scaffold(
      //   body: TakeMomentPage(),
      // ),
      // home: const BestMomentsPage(),
      // home: const CountTimePage(),
      home: const SafePage(),
      theme: AppTheme.themeData,
    ),
  );
}
