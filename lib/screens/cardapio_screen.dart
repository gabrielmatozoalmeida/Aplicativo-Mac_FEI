import 'package:flutter/material.dart';
import '../models/cardapio.dart';

class CardapioScreen extends StatelessWidget {
  final List<ItemCardapio> cardapio = [
    ItemCardapio(id: '1', nome: 'Prato Executivo', preco: 12.00, precisaAgendar: true),
    ItemCardapio(id: '2', nome: 'Sanduíche Natural', preco: 8.00, precisaAgendar: false),
    ItemCardapio(id: '3', nome: 'Suco de Laranja', preco: 5.00, precisaAgendar: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cardápio'),
      ),
      body: ListView.builder(
        itemCount: cardapio.length,
        itemBuilder: (context, index) {
          final item = cardapio[index];
          return ListTile(
            title: Text(item.nome),
            subtitle: Text('R\$ ${item.preco.toStringAsFixed(2)}'),
            trailing: Icon(item.precisaAgendar ? Icons.schedule : Icons.fastfood),
            onTap: () {
              // Ação para selecionar o item do cardápio e passar para o pagamento ou agendar retirada
              Navigator.pushNamed(
                context,
                '/pagamento', // Vai para a tela de pagamento
                arguments: item, // Envia o item do cardápio como argumento
              );
            },
          );
        },
      ),
    );
  }
}
