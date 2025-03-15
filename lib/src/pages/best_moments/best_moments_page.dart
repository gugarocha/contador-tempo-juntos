import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/env/env.dart';
import '../../core/ui/constants.dart';
import '../../core/utils/util_functions.dart';
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

  void _nextImageTimerCallback(Timer timer) {
    setState(() {
      _imageTimer += 1;
    });

    if (_imageTimer % timePerImage == 0) {
      if (_currentImageIndex == imageUrls.length - 1) {
        _timer.cancel();
        UtilFunctions.navigateTo(context, const TakeMomentPage());
        return;
      }

      setState(() {
        _currentImageIndex += 1;
        _imageTimer = 0;
      });
    }
  }

  void _onLeftTap() {
    if (_currentImageIndex > 0) {
      setState(() {
        _currentImageIndex -= 1;
        _imageTimer = 0;
      });
    }
  }

  void _onRightTap() {
    if (_currentImageIndex < imageUrls.length - 1) {
      setState(() {
        _currentImageIndex += 1;
        _imageTimer = 0;
      });
      return;
    }
    UtilFunctions.navigateTo(context, const TakeMomentPage());
  }

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
    final screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: Stack(
        children: [
          FadeInImage.assetNetwork(
            placeholder: ImagesConstants.loading,
            image: imageUrls[_currentImageIndex],
            width: screenWidth,
            fit: BoxFit.cover,
          ),
          // Image.network(
          //   imageUrls[_currentImageIndex],
          //   width: screenWidth,
          //   fit: BoxFit.cover,
          // ),
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
              width: screenWidth,
              height: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: imageUrls.length,
                  separatorBuilder: (ctx, i) => const SizedBox(width: 5),
                  itemBuilder: (ctx, i) {
                    final indicatorWidth =
                        (screenWidth - 10) / imageUrls.length;
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
