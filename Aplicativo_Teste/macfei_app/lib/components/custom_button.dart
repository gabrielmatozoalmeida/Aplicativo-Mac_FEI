import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;

  CustomButton({required this.text, required this.onPressed, this.color = Colors.green});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(primary: color),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
