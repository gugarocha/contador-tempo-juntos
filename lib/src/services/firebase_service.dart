import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();

  factory FirebaseService() => _instance;

  FirebaseService._internal();

  Future<String> getImage(String imageName) async {
    final storageRef = FirebaseStorage.instance.ref('images');
    final imageUrl = await storageRef.child(imageName).getDownloadURL();

    return imageUrl;
  }

  Future<List<String>> getImagesUrls(String ref) async {
    final storageRef = FirebaseStorage.instance.ref(ref);
    final imagesListResult = await storageRef.listAll();
    
    final urls = await Future.wait(
      imagesListResult.items.map((item) => item.getDownloadURL()).toList(),
    );

    return urls;
  }
}
