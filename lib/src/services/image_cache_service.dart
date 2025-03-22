import 'package:flutter/widgets.dart';

class ImageCacheService {
  static final ImageCacheService _instance = ImageCacheService._internal();

  factory ImageCacheService() => _instance;

  ImageCacheService._internal();
  
  Future<List<ImageProvider>> cacheImages(
    BuildContext context,
    List<String> urls,
  ) async {
    final List<ImageProvider> images = [];

    for (String url in urls) {
      final ImageProvider image = NetworkImage(url);
      await precacheImage(image, context);
      images.add(image);
    }

    return images;
  }
}
