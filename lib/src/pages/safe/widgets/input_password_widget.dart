import 'package:flutter/material.dart';

class InputPasswordWidget extends StatelessWidget {
  final List<String> inputPassword;

  const InputPasswordWidget(this.inputPassword, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.grey, width: 0.5),
      ),
      height: 75,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Center(
        child: Row(
          children: [
            _InputChar(inputPassword[0]),
            _InputChar(inputPassword[1]),
            _InputChar(inputPassword[2]),
            _InputChar(inputPassword[3]),
            _InputChar(inputPassword[4]),
            _InputChar(inputPassword[5]),
          ],
        ),
      ),
    );
  }
}

class _InputChar extends StatelessWidget {
  final String char;

  const _InputChar(this.char);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          char.isEmpty ? '' : '*',
          style: const TextStyle(
            fontSize: 65,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
