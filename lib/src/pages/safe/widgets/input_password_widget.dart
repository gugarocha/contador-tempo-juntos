import 'package:flutter/material.dart';

class InputPasswordWidget extends StatelessWidget {
  final List<String> inputPassword;

  const InputPasswordWidget(this.inputPassword, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 274,
      height: 75,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      color: Colors.black,
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
            // backgroundColor: Colors.amber,
            fontSize: 65,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
