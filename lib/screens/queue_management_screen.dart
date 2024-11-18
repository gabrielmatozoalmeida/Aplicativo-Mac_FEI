import 'package:flutter/material.dart';

class QueueManagementScreen extends StatefulWidget {
  final List<Map<String, dynamic>> orders;
  final bool isFromCustomer; // Identifica a origem da navegação

  const QueueManagementScreen({
    Key? key,
    required this.orders,
    this.isFromCustomer = false,
  }) : super(key: key);

  @override
  State<QueueManagementScreen> createState() => _QueueManagementScreenState();
}

class _QueueManagementScreenState extends State<QueueManagementScreen> {
  late List<Map<String, dynamic>> sortedOrders;

  @override
  void initState() {
    super.initState();
    // Ordenar pedidos por tempo de preparo
    sortedOrders = List.from(widget.orders)
      ..sort((a, b) => a['prepTime'].compareTo(b['prepTime']));

    // Definir o pedido como "Em preparação" se vier do cliente
    if (widget.isFromCustomer && sortedOrders.isNotEmpty) {
      sortedOrders[0]['status'] = 'Em preparação';
    }
  }

  void _markAsDelivered(int index) {
    setState(() {
      sortedOrders[index]['status'] = 'Entregue';
      sortedOrders.removeAt(index);
    });
  }

  String _formatTime(int minutes) {
    return '${minutes ~/ 60}h ${minutes % 60}min';
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
          children: [
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
                  return Card(
                    child: ListTile(
                      title: Text('Pedido #${order['id']} - ${order['item']}'),
                      subtitle: Text(
                        'Status: ${order['status']} | Tempo: ${_formatTime(order['prepTime'])}',
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {
                          _markAsDelivered(index);
                          Navigator.pop(context); // Voltar para AdminScreen
                        },
                        child: const Text('Entregar'),
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
