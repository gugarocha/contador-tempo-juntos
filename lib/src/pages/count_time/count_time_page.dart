import 'package:flutter/material.dart';

import '../../core/ui/constants.dart';
import '../../core/ui/widgets/content_container.dart';
import '../../core/ui/widgets/heart_widget.dart';
import '../../core/utils/util_functions.dart';
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
                        height: 30,
                      ),
                      ContentContainer(
                        child: Column(
                          children: [
                            HeartWidget(),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '"Cada segundo ao seu lado é um segundo que me faz mais feliz. Te amo para todo o sempre."',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        '🐧 Compartilhando\nmomentos há',
                        textAlign: TextAlign.center,
                        style: FontsConstants.titleLarge,
                      ),
                    ],
                  ),
                ),
              ),
              const SliverPadding(
                padding: EdgeInsets.symmetric(vertical: 20),
                sliver: CountDown(),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                sliver: SliverToBoxAdapter(
                  child: ElevatedButton(
                    onPressed: () async {
                      UtilFunctions.navigateTo(
                        context,
                        const BestMomentsPage(),
                        pushReplacement: false,
                      );
                    },
                    child: const Row(
                      children: [
                        Text(
                          'Conferir melhores momentos',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.arrow_right_alt,
                          size: 24,
                        ),
                      ],
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
