import 'package:flutter/material.dart';
import 'dart:async';

class SchedulePickupScreen extends StatefulWidget {
  final dynamic args;

  const SchedulePickupScreen({Key? key, required this.args}) : super(key: key);

  @override
  _SchedulePickupScreen createState() => _SchedulePickupScreen();
}

class _SchedulePickupScreen extends State<SchedulePickupScreen> {
  late String orderType;
  late List<Map<String, dynamic>> items;
  late int totalTime; // Tempo total de preparo em segundos
  late int elapsedTime; // Tempo decorrido em segundos
  late Timer timer;
  late List<Map<String, dynamic>> orderHistory; // Histórico de pedidos

  @override
  void initState() {
    super.initState();

    // Inicializando os valores recebidos de forma segura
    orderType = widget.args['orderType'] ?? 'Desconhecido';
    items = List<Map<String, dynamic>>.from(widget.args['items'] ?? []);

    // Garantindo que cada item tenha a chave 'prepTime' e é um número
    totalTime = items.fold(0, (sum, item) {
      // Verifica se 'prepTime' é um número e soma
      final prepTime = item['prepTime'];
      if (prepTime is int) {
        return sum + prepTime;
      } else if (prepTime is double) {
        return sum + prepTime.toInt();  // Se for double, converte para inteiro
      }
      return sum;  // Se não for um número, ignora
    });

    elapsedTime = 0;

    // Inicializa o timer se o totalTime for maior que zero
    if (totalTime > 0) {
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          elapsedTime++;
          if (elapsedTime >= totalTime) {
            timer.cancel();
          }
        });
      });
    }

    // Histórico simulado de pedidos para exemplo
    orderHistory = [
      {'id': 1, 'description': 'Pedido anterior 1', 'total': 25.0, 'status': 'Concluído'},
      {'id': 2, 'description': 'Pedido anterior 2', 'total': 45.0, 'status': 'Concluído'},
    ];
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Calcula progresso
    double progress = totalTime == 0 ? 1 : elapsedTime / totalTime;

    // Mensagem de status
    String statusMessage = (orderType == 'bebida' || orderType == 'salgado')
        ? 'Pronto para retirada no balcão.'
        : 'Seu pedido está sendo preparado. Aguarde.';

    return Scaffold(
      appBar: AppBar(title: const Text('Meus Pedidos')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Histórico de Pedidos',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: orderHistory.length,
                itemBuilder: (context, index) {
                  final order = orderHistory[index];
                  return Card(
                    child: ListTile(
                      title: Text(order['description']),
                      subtitle: Text('Status: ${order['status']}'),
                      trailing: Text('R\$ ${order['total'].toStringAsFixed(2)}'),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Status do Pedido Atual',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                statusMessage,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                'Tempo restante: ${totalTime - elapsedTime}s',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[300],
                color: Colors.green,
                minHeight: 10,
              ),
              const SizedBox(height: 16),
              if (elapsedTime >= totalTime)
                const Text(
                  'Pedido pronto para retirada!',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
