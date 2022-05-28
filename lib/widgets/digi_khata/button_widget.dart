import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    required this.text,
    required this.onClicked,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Colors.red[400]),
        onPressed: onClicked,
        child: Text(
          text,
          style: const TextStyle(fontSize: 24),
        ),
      );
}
