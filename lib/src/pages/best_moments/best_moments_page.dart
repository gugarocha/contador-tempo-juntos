import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../core/ui/extensions/size_extension.dart';
import '../../core/utils/util_functions.dart';
import '../../models/image_model.dart';
import '../../services/firebase_service.dart';
import '../../services/image_cache_service.dart';
import '../camera/camera_page.dart';
import '../take_moment/take_moment_page.dart';
import 'widgets/blurred_background_image.dart';

class BestMomentsPage extends StatefulWidget {
  const BestMomentsPage({super.key});

  @override
  State<BestMomentsPage> createState() => _BestMomentsPageState();
}

class _BestMomentsPageState extends State<BestMomentsPage> {
  static const timePerImage = 5;

  final _storageService = FirebaseService();
  final _imageCacheService = ImageCacheService();

  late Future<List<ImageProvider>> _imagesFuture;
  List<ImageModel> _imagesModelList = [];

  Timer? _timer;
  int _currentImageIndex = 0;
  int _imageTimer = 0;
  int _imagesCount = 0;
  bool _prepareToPhoto = false;

  Future<List<ImageModel>> _loadImages() async {
    final imagesModelList =
        await _storageService.getImages('images/best-moments');
    return imagesModelList;
  }

  Future<List<ImageProvider>> _cacheImages() async {
    final imagesModelList = await _loadImages();

    setState(() {
      _imagesModelList = imagesModelList;
    });

    final images = _imageCacheService.cacheImages(context, imagesModelList);
    return images;
  }

  void _startTimer() {
    _timer ??= Timer.periodic(
      const Duration(seconds: 1),
      _nextImageTimerCallback,
    );
  }

  void _nextImageTimerCallback(Timer timer) {
    setState(() {
      _imageTimer += 1;
    });

    if (_imageTimer % timePerImage == 0) {
      if (_prepareToPhoto) {
        _timer?.cancel();
        _loadCameras();
        return;
      }

      setState(() {
        if (_currentImageIndex == _imagesCount - 1) {
          _prepareToPhoto = true;
        }
        _imageTimer = 0;
        _currentImageIndex += 1;
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
      if (_currentImageIndex == _imagesCount - 1) {
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
    _imagesFuture = _cacheImages();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<ImageProvider>>(
        future: _imagesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Erro ao carregar as imagens'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhuma imagem encontrada.'));
          }

          final images = snapshot.data!;

          WidgetsBinding.instance.addPostFrameCallback((_) {
            _startTimer();
            _imagesCount = images.length;
          });

          return Stack(
            children: [
              _prepareToPhoto
                  ? const TakeMomentPage()
                  : BlurredBackgroundImage(
                      image: images[_currentImageIndex],
                      imageDate: _imagesModelList[_currentImageIndex]
                          .getImageDateInFull(),
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
                      itemCount: images.length + 1,
                      separatorBuilder: (ctx, i) => const SizedBox(width: 5),
                      itemBuilder: (ctx, i) {
                        final indicatorWidth =
                            (context.screenWidth - 10) / (images.length + 1);
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
          );
        },
      ),
    );
  }
}
