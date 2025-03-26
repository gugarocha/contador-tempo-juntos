import 'package:firebase_storage/firebase_storage.dart';

import '../models/image_model.dart';

class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();

  factory FirebaseService() => _instance;

  FirebaseService._internal();

  Future<String> getImage(String imageName) async {
    final storageRef = FirebaseStorage.instance.ref('images');
    final imageUrl = await storageRef.child(imageName).getDownloadURL();

    return imageUrl;
  }

  Future<List<ImageModel>> getImages(String ref) async {
    final List<ImageModel> imagesList = [];

    final storageRef = FirebaseStorage.instance.ref(ref);
    final imagesListResult = await storageRef.listAll();

    for (var item in imagesListResult.items) {
      imagesList.add(
        ImageModel(
          url: await item.getDownloadURL(),
          imageDate: item.name,
        ),
      );
    }

    return imagesList;
  }
}
