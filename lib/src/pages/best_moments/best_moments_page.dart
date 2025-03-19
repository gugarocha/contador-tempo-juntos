import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../core/env/env.dart';
import '../../core/ui/constants.dart';
import '../../core/ui/extensions/size_extension.dart';
import '../../core/utils/util_functions.dart';
import '../camera/camera_page.dart';
import '../take_moment/take_moment_page.dart';

final imageUrls = [
  Env.instance.get('best_moments_1'),
  Env.instance.get('best_moments_2'),
  Env.instance.get('best_moments_3'),
];

class BestMomentsPage extends StatefulWidget {
  const BestMomentsPage({super.key});

  @override
  State<BestMomentsPage> createState() => _BestMomentsPageState();
}

class _BestMomentsPageState extends State<BestMomentsPage> {
  static const timePerImage = 5;

  late Timer _timer;
  int _currentImageIndex = 0;
  int _imageTimer = 0;
  bool _prepareToPhoto = false;

  void _nextImageTimerCallback(Timer timer) {
    setState(() {
      _imageTimer += 1;
    });

    if (_imageTimer % timePerImage == 0) {
      if (_prepareToPhoto) {
        _timer.cancel();
        _loadCameras();
        return;
      }

      if (_currentImageIndex == imageUrls.length - 1) {
        setState(() {
          _prepareToPhoto = true;
          _imageTimer = 0;
        });
        return;
      }

      setState(() {
        _currentImageIndex += 1;
        _imageTimer = 0;
      });
    }
  }

  void _onLeftTap() {
    if (_prepareToPhoto) {
      setState(() {
        _prepareToPhoto = false;
        _imageTimer = 0;
      });
    }

    if (_currentImageIndex > 0) {
      setState(() {
        _currentImageIndex -= 1;
        _imageTimer = 0;
      });
      return;
    }
  }

  void _onRightTap() {
    if (_prepareToPhoto) {
      _loadCameras();
      return;
    }

    setState(() {
      if (_currentImageIndex == imageUrls.length - 1) {
        _prepareToPhoto = true;
      }
      _currentImageIndex += 1;
      _imageTimer = 0;
    });
  }

  void _loadCameras() async {
    availableCameras().then(
      (value) => _navigateToCameraPage(value),
    );
  }

  void _navigateToCameraPage(List<CameraDescription> cameras) =>
      UtilFunctions.navigateTo(context, CameraPage(cameras));

  @override
  void initState() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      _nextImageTimerCallback,
    );
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _prepareToPhoto
              ? const TakeMomentPage()
              : FadeInImage.assetNetwork(
                  placeholder: ImagesConstants.loading,
                  image: imageUrls[_currentImageIndex],
                  width: context.screenWidth,
                  fit: BoxFit.cover,
                ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: _onLeftTap,
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: _onRightTap,
                ),
              ),
            ],
          ),
          Positioned(
            top: 10,
            child: SizedBox(
              width: context.screenWidth,
              height: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: imageUrls.length + 1,
                  separatorBuilder: (ctx, i) => const SizedBox(width: 5),
                  itemBuilder: (ctx, i) {
                    final indicatorWidth =
                        (context.screenWidth - 10) / (imageUrls.length + 1);
                    double value;
                    if (_currentImageIndex == i) {
                      value = _imageTimer / timePerImage;
                    } else {
                      value = i < _currentImageIndex ? 1 : 0;
                    }
                    return SizedBox(
                      width: indicatorWidth,
                      child: LinearProgressIndicator(
                        value: value,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
