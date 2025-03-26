import 'package:flutter/widgets.dart';

import '../models/image_model.dart';

class ImageCacheService {
  static final ImageCacheService _instance = ImageCacheService._internal();

  factory ImageCacheService() => _instance;

  ImageCacheService._internal();
  
  Future<List<ImageProvider>> cacheImages(
    BuildContext context,
    List<ImageModel> imagesModelList,
  ) async {
    final List<ImageProvider> images = [];

    for (var item in imagesModelList) {
      final ImageProvider image = NetworkImage(item.url);
      await precacheImage(image, context);
      images.add(image);
    }

    return images;
  }
}
