import 'dart:developer';
import 'dart:typed_data';
import 'package:exif/exif.dart';
import 'package:http/http.dart' as http;

import '../core/utils/util_functions.dart';

class ImageMetadataService {
  static final ImageMetadataService _instance =
      ImageMetadataService._internal();

  factory ImageMetadataService() => _instance;

  ImageMetadataService._internal();

  Future<Map<String, dynamic>> _getImageMetadataFromUrl(
    String imageUrl,
  ) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode != 200) {
        return {};
      }

      final Uint8List imageBytes = response.bodyBytes;
      final data = await readExifFromBytes(imageBytes);

      return data;
    } catch (e) {
      log('Error on get metadata: $e');
      return {};
    }
  }

  Future<String> getImageDateInFull(String imageUrl) async {
    final data = await _getImageMetadataFromUrl(imageUrl);

    if (data.containsKey('EXIF DateTimeOriginal')) {
      final rawDate = data['EXIF DateTimeOriginal'].toString();
      final date = rawDate.split(' ')[0].split(':');

      final month = UtilFunctions.getMonthFromNumber(int.parse(date[1]));
      return '${date[2]} de $month, ${date[0]}';
    }

    return '';
  }
}
