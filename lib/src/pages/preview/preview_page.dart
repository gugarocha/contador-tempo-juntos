import 'dart:developer';

import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../core/ui/extensions/size_extension.dart';
import '../../core/ui/widgets/polaroid_frame.dart';

class PreviewPage extends StatefulWidget {
  const PreviewPage(this.imageBytes, {super.key});

  final Uint8List imageBytes;

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  bool _isUploading = false;

  void _uploadImage() {
    try {
      final storageRef = FirebaseStorage.instance.ref('images');
      final uploadTask = storageRef.child('moment.jpg').putData(
            widget.imageBytes,
            SettableMetadata(contentType: 'image/jpeg'),
          );

      uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
        switch (taskSnapshot.state) {
          case TaskState.running:
            setState(() {
              _isUploading = true;
            });
            break;
          case _:
            setState(() {
              _isUploading = false;
            });
            break;
        }
      });
    } on firebase_core.FirebaseException catch (e) {
      log('Error on upload image: ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: _uploadImage),
      body: Center(
        child: Stack(
          children: [
            PolaroidFrame(
              frameWidth: context.percentWidth(0.90),
              frameHeight: context.percentHeight(0.85),
              imageWidth: context.percentWidth(0.80),
              imageHeight: context.percentHeight(0.72),
              marginTop: 20,
              child: Image(
                image: MemoryImage(widget.imageBytes),
                fit: BoxFit.cover,
                width: 250,
              ),
            ),
            if (_isUploading)
              const Positioned.fill(
                child: Stack(
                  children: [
                    ModalBarrier(
                      color: Colors.black54,
                      dismissible: false,
                    ),
                    Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
