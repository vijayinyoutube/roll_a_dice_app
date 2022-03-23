import 'package:flutter/material.dart';

class TextData extends StatelessWidget {
  const TextData({
    Key? key,
    required this.message1, required this.message2,
  }) : super(key: key);

  final String message1;
  final String message2;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '$message1 ',
        style: const TextStyle(fontSize: 25.00),
        children: <TextSpan>[
          TextSpan(
            text: message2,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.00,
                color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
