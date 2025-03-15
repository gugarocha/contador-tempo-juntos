import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../best_moments/best_moments_page.dart';
import 'widgets/count_down.dart';
import 'widgets/polaroid_image.dart';

class CountTimePage extends StatefulWidget {
  const CountTimePage({super.key});

  @override
  State<CountTimePage> createState() => _CountTimePageState();
}

class _CountTimePageState extends State<CountTimePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 350),
          child: CustomScrollView(
            slivers: [
              const SliverPadding(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    children: [
                      PolaroidImage(),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        '🐧 Compartilhando momentos há',
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 36,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const CountDown(),
              SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                sliver: SliverToBoxAdapter(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (ctx) => const BestMomentsPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Conferir melhores momentos →',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
