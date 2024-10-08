import 'package:flutter/material.dart';
import '../models/pedido.dart';

class PedidoCard extends StatelessWidget {
  final Pedido pedido;

  PedidoCard({required this.pedido});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(pedido.itemCardapio),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Cliente: ${pedido.nomeCliente}'),
            Text('Horário de Retirada: ${pedido.horarioRetirada}'),
          ],
        ),
        trailing: pedido.pronto
            ? Icon(Icons.check, color: Colors.green)
            : Icon(Icons.timer, color: Colors.orange),
      ),
    );
  }
}
