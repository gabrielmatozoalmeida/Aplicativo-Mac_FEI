import 'package:flutter/material.dart';

class SchedulePickupScreen extends StatelessWidget {
  final String orderType; // Define o tipo do pedido (ex.: "prato", "bebida", "salgado")
  final bool isReady; // Indica se o pedido já está pronto ou não

  const SchedulePickupScreen({
    super.key,
    required this.orderType,
    required this.isReady,
  });

  String getStatusMessage() {
    if (isReady) {
      if (orderType == 'bebida' || orderType == 'salgado') {
        return 'Seu pedido está pronto! Por favor, retire no balcão.';
      } else if (orderType == 'prato') {
        return 'Seu prato está pronto! Por favor, retire no horário agendado.';
      }
    } else {
      if (orderType == 'prato') {
        return 'Seu pedido está sendo preparado. Aguarde o horário agendado.';
      } else {
        return 'Seu pedido está sendo processado. Por favor, aguarde.';
      }
    }
    return 'Status do pedido não disponível.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Status do Pedido'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            getStatusMessage(),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
