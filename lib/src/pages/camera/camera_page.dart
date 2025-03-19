import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../core/ui/extensions/size_extension.dart';
import '../../core/ui/widgets/polaroid_frame.dart';
import '../../core/utils/util_functions.dart';
import '../preview/preview_page.dart';

class CameraPage extends StatefulWidget {
  const CameraPage(this._cameras, {super.key});

  final List<CameraDescription> _cameras;

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;

  void _navigateToPreviewPage(Uint8List imageBytes) {
    UtilFunctions.navigateTo(context, PreviewPage(imageBytes));
  }

  Future<void> _takePicture() async {
    if (!_cameraController.value.isInitialized ||
        _cameraController.value.isTakingPicture) {
      return;
    }

    try {
      final image = await _cameraController.takePicture();
      final imageBytes = await image.readAsBytes();

      _navigateToPreviewPage(imageBytes);
    } on CameraException catch (e) {
      debugPrint('Error occured while taking picture: $e');
      return;
    }
  }

  @override
  void initState() {
    _cameraController = CameraController(
      widget._cameras[0],
      ResolutionPreset.max,
      enableAudio: false,
    );

    _initializeControllerFuture = _cameraController.initialize();

    super.initState();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: _takePicture),
      body: Center(
        child: FutureBuilder(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return PolaroidFrame(
                frameWidth: context.percentWidth(0.90),
                frameHeight: context.percentHeight(0.85),
                imageWidth: context.percentWidth(0.80),
                imageHeight: context.percentHeight(0.72),
                marginTop: 20,
                child: CameraPreview(_cameraController),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
