import 'dart:async';

import 'package:flutter/material.dart';

enum LightState { idle, success, error }

class IndicatorLightWidget extends StatefulWidget {
  final LightState state;

  const IndicatorLightWidget(this.state, {super.key});

  @override
  State<IndicatorLightWidget> createState() => _IndicatorLightWidgetState();
}

class _IndicatorLightWidgetState extends State<IndicatorLightWidget> {
  Color _currentColor = const Color(0xFFD6EFD8);
  bool _isBlinking = false;

  @override
  void didUpdateWidget(covariant IndicatorLightWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.state != oldWidget.state) {
      _updateLightColor();
    }
  }

  void _updateLightColor() {
    if (widget.state == LightState.success) {
      setState(() => _currentColor = const Color(0xFF06D001));
    } else if (widget.state == LightState.error) {
      _blinkErrorLight();
    } else {
      setState(() => _currentColor = const Color(0xFFD6EFD8));
    }
  }

  void _blinkErrorLight() {
    if (_isBlinking) return;
    _isBlinking = true;

    final List<Color> colors = [
      const Color(0xFFDD0000),
      const Color(0xFFD6EFD8),
    ];

    const int blinkCount = 3;
    int counter = 0;

    Timer.periodic(const Duration(milliseconds: 300), (timer) {
      setState(() {
        _currentColor = colors[counter % 2];
      });

      counter++;
      if (counter >= blinkCount * 2) {
        timer.cancel();
        setState(() {
          _currentColor = const Color(0xFFD6EFD8);
          _isBlinking = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 8,
          width: 250,
          margin: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.elliptical(60, 5)),
            color: _currentColor,
            boxShadow: [
              BoxShadow(
                color: _currentColor.withOpacity(0.6),
                blurRadius: _currentColor == const Color(0xFFD6EFD8) ? 0 : 8,
                spreadRadius: _currentColor == const Color(0xFFD6EFD8) ? 0 : 4,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
