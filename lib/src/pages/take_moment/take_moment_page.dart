import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../core/utils/util_functions.dart';
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
    return const Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          SizedBox(
             height: 50,
          ),
          Text(
            'Que tal registrar mais\nUM MOMENTO\nagora?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 54,
            ),
          ),
        ],
      ),
    );
  }
}
