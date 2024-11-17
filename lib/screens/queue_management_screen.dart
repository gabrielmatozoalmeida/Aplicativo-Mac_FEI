import 'package:flutter/material.dart';
import 'dart:async';

class QueueManagementScreen extends StatefulWidget {
  final List<Map<String, dynamic>> orders; // Receberá os pedidos via construtor

  const QueueManagementScreen({Key? key, required this.orders}) : super(key: key);

  @override
  State<QueueManagementScreen> createState() => _QueueManagementScreenState();
}

class _QueueManagementScreenState extends State<QueueManagementScreen> {
  late List<Map<String, dynamic>> sortedOrders;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    sortedOrders = List.from(widget.orders)
      ..sort((a, b) => a['prepTime'].compareTo(b['prepTime']));

    // Converte o tempo de preparação de minutos para segundos
    for (var order in sortedOrders) {
      if (order['status'] == 'Em preparação') {
        order['prepTime'] = order['prepTime'] * 60; // Convertendo minutos para segundos
      }
    }

    // Atualiza o tempo de preparo em tempo real
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        for (var order in sortedOrders) {
          if (order['status'] == 'Em preparação' && order['prepTime'] > 0) {
            order['prepTime']--;
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateOrderStatus(int index) {
    setState(() {
      // Atualiza o status do pedido
      if (sortedOrders[index]['status'] == 'Pendente') {
        sortedOrders[index]['status'] = 'Em preparação';
        sortedOrders[index]['prepTime'] *= 60; // Converte para segundos ao iniciar
      } else if (sortedOrders[index]['status'] == 'Em preparação') {
        sortedOrders[index]['status'] = 'Pronto para entrega';
      } else if (sortedOrders[index]['status'] == 'Pronto para entrega') {
        sortedOrders[index]['status'] = 'Entregue';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Pedido #${sortedOrders[index]['id']} entregue!')),
        );
        sortedOrders.removeAt(index);
      }
    });
  }

  void _markAsDelivered(int index) {
    setState(() {
      sortedOrders[index]['status'] = 'Entregue';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pedido #${sortedOrders[index]['id']} entregue!')),
      );
      sortedOrders.removeAt(index); // Remove o pedido depois de marcado como entregue
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60; // Divide para pegar os minutos
    int remainingSeconds = seconds % 60; // Pega o resto para os segundos
    return '$minutes min ${remainingSeconds.toString().padLeft(2, '0')} sec'; // Formato "min sec"
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciamento de Filas'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  sortedOrders = List.from(widget.orders)
                    ..sort((a, b) => a['prepTime'].compareTo(b['prepTime']));
                });
              },
              child: const Text('Atualizar Pedidos'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Pedidos em Fila',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: sortedOrders.length,
                itemBuilder: (context, index) {
                  final order = sortedOrders[index];
                  String prepTime = order['status'] == 'Em preparação' && order['prepTime'] > 0
                      ? _formatTime(order['prepTime'])
                      : 'N/A';

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text('Pedido #${order['id']} - ${order['item']}'),
                      subtitle: Text(
                        'Status: ${order['status']} | Tempo restante: $prepTime',
                      ),
                      trailing: order['status'] == 'Pronto para entrega'
                          ? ElevatedButton(
                              onPressed: () => _markAsDelivered(index),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                              child: const Text('Entregar'),
                            )
                          : ElevatedButton(
                              onPressed: () => _updateOrderStatus(index),
                              child: Text(order['status'] == 'Pendente'
                                  ? 'Iniciar Preparação'
                                  : 'Atualizar'),
                            ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
