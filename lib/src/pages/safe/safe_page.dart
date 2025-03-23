import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../core/ui/constants.dart';
import '../../core/ui/widgets/heart_widget.dart';
import '../count_time/count_time_page.dart';
import 'widgets/indicator_light_widget.dart';
import 'widgets/input_password_widget.dart';
import 'widgets/keyboard_item.dart';
import 'widgets/safe_container.dart';

class SafePage extends StatefulWidget {
  const SafePage({super.key});

  @override
  State<SafePage> createState() => _SafePageState();
}

class _SafePageState extends State<SafePage> {
  final List<String> inputPassword = ['', '', '', '', '', ''];
  int currentCharIndex = 0;
  LightState _lightState = LightState.idle;

  bool _validatePassword() {
    final isValid = listEquals(['2', '6', '0', '3', '2', '1'], inputPassword);

    if (isValid) {
      setState(() => _lightState = LightState.success);
    } else {
      setState(() => _lightState = LightState.error);
    }

    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    final List<String> keyboardChars = [
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '',
      '0',
    ];

    void navigateToCountTimePage() {
      Navigator.of(context).pushReplacement(
        CupertinoPageRoute(
          builder: (ctx) => const CountTimePage(),
        ),
      );
    }

    void onKeyboardCharPressed(String char) async {
      setState(() {
        inputPassword[currentCharIndex] = char;
        currentCharIndex += 1;
      });

      if (currentCharIndex == 6) {
        final isValid = _validatePassword();

        await Future.delayed(const Duration(seconds: 2));

        setState(() {
          currentCharIndex = 0;
          inputPassword[0] = '';
          inputPassword[1] = '';
          inputPassword[2] = '';
          inputPassword[3] = '';
          inputPassword[4] = '';
          inputPassword[5] = '';
          _lightState = LightState.idle;
        });

        if (isValid) navigateToCountTimePage();
      }
    }

    return Scaffold(
      body: Center(
        child: FittedBox(
          child: SafeContainer(
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(224, 170, 255, 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.lock_outline,
                    size: 45,
                    color: ColorsConstants.primary,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Nosso Cofre Digital',
                  style: FontsConstants.titleMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Digite a senha para acessar nossas memórias',
                  textAlign: TextAlign.center,
                  style: FontsConstants.bodySmall,
                ),
                const HeartWidget(),
                InputPasswordWidget(inputPassword),
                const SizedBox(
                  height: 20,
                ),
                IndicatorLightWidget(_lightState),
                const SizedBox(
                  height: 20,
                ),
                GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 3 / 2,
                  shrinkWrap: true,
                  children: keyboardChars
                      .map(
                        (char) => char.isEmpty
                            ? const SizedBox()
                            : KeyboardItem(
                                char: char,
                                onPressed: () => onKeyboardCharPressed(char),
                              ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
