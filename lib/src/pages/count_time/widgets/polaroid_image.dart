import 'package:flutter/material.dart';

import '../../../core/ui/widgets/polaroid_frame.dart';
import '../../../services/firebase_service.dart';

class PolaroidImage extends StatefulWidget {
  const PolaroidImage({super.key});

  @override
  State<PolaroidImage> createState() => _PolaroidImageState();
}

class _PolaroidImageState extends State<PolaroidImage> {
  final _storageService = FirebaseService();

  String? _imageUrl;
  double _opacity = 0.0;

  Future<void> _loadMainImage() async {
    final url = await _storageService.getImage('main.jpg');
    setState(() {
      _imageUrl = url;
    });
  }

  void _startRevealEffect() {
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  void initState() {
    _loadMainImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PolaroidFrame(
      child: _imageUrl == null
          ? const SizedBox()
          : Image.network(
              _imageUrl!,
              width: 240,
              height: 240,
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  _startRevealEffect();
                }
                return AnimatedOpacity(
                  duration: const Duration(seconds: 6),
                  curve: Curves.linear,
                  opacity: _opacity,
                  child: child,
                );
              },
            ),
    );
  }
}
