import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/utils/util_functions.dart';
import '../best_moments/best_moments_page.dart';
import '../camera/camera_page.dart';

class TakeMomentPage extends StatefulWidget {
  const TakeMomentPage({super.key});

  @override
  State<TakeMomentPage> createState() => _TakeMomentPageState();
}

class _TakeMomentPageState extends State<TakeMomentPage> {
  void _navigateToCameraPage(List<CameraDescription> cameras) =>
      UtilFunctions.navigateTo(context, CameraPage(cameras));

  void _openCamera() async {
    availableCameras().then(
      (value) => _navigateToCameraPage(value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Que tal registrar um momento agora?'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _openCamera(),
          child: const Text('Registrar momento'),
        ),
      ),
    );
  }
}
