import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

import '../../../core/ui/constants.dart';

class CountDown extends StatefulWidget {
  const CountDown({super.key});

  @override
  State<CountDown> createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> {
  final ourDate = Jiffy.parseFromList([2021, 3, 26]);
  late Timer _timer;

  int years = 0;
  int months = 0;
  int days = 0;
  int hours = 0;
  int minutes = 0;
  int seconds = 0;

  void _updateTime() {
    final now = Jiffy.now();
    final daysDiff = (ourDate.date - now.date).abs();

    years = now.diff(ourDate, unit: Unit.year).toInt();
    months = now.diff(ourDate, unit: Unit.month).toInt() % 12;
    days = ourDate.date > now.date ? 30 - daysDiff : daysDiff;
    hours = now.diff(ourDate, unit: Unit.hour).toInt() % 24;
    minutes = now.diff(ourDate, unit: Unit.minute).toInt() % 60;
    seconds = now.diff(ourDate, unit: Unit.second).toInt() % 60;
    setState(() {});
  }

  @override
  void initState() {
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTime();
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      childAspectRatio: 10 / 7,
      children: [
        _TimeAnimatedContainer(
          time: '$years',
          label: 'Anos',
        ),
        _TimeAnimatedContainer(
          time: '$months',
          label: 'Meses',
        ),
        _TimeAnimatedContainer(
          time: '$days',
          label: 'Dias',
        ),
        _TimeAnimatedContainer(
          time: '$hours',
          label: 'Horas',
        ),
        _TimeAnimatedContainer(
          time: '$minutes',
          label: 'Minutos',
        ),
        _TimeAnimatedContainer(
          time: '$seconds',
          label: 'Segundos',
        ),
      ],
    );
  }
}

class _TimeAnimatedContainer extends StatelessWidget {
  final String time;
  final String label;

  const _TimeAnimatedContainer({
    required this.time,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: const BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            time,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: ColorsConstants.secondary,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
