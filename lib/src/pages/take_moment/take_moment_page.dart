import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../core/ui/constants.dart';
import '../../core/ui/widgets/circular_icon.dart';
import '../../core/ui/widgets/content_container.dart';
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
    return ContentContainer(
      child: Column(
        children: [
          const CircularIcon(Icons.camera_alt_outlined),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Text(
              'Que tal registrar mais\nUM MOMENTO\nagora?',
              textAlign: TextAlign.center,
              style: FontsConstants.titleMedium,
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.camera_alt_outlined,
                    size: 24,
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Tirar foto',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
