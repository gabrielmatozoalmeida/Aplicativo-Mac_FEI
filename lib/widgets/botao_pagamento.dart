import 'package:flutter/material.dart';

class BotaoPagamento extends StatelessWidget {
  final String texto;
  final VoidCallback onPressed;

  BotaoPagamento({required this.texto, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      ),
      child: Text(texto),
    );
  }
}
