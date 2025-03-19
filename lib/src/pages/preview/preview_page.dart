import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PreviewPage extends StatefulWidget {
  const PreviewPage(this.imageBytes, {super.key});

  final Uint8List imageBytes;

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image(
              image: MemoryImage(widget.imageBytes),
              fit: BoxFit.cover,
              width: 250,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
