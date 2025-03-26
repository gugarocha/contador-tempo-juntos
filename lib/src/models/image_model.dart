import '../core/utils/util_functions.dart';

class ImageModel {
  String url;
  String imageDate;

  ImageModel({
    required this.url,
    required this.imageDate,
  });

  String getImageDateInFull() {
    final date = imageDate.split('.')[0].split('-');
    final month = UtilFunctions.getMonthFromNumber(int.parse(date[1]));

    return '${date[2]} de $month, ${date[0]}';
  }
}
