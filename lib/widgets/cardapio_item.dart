import 'package:flutter/material.dart';
import '../models/cardapio.dart';

class CardapioItem extends StatelessWidget {
  final ItemCardapio item;
  final VoidCallback onTap;

  CardapioItem({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.nome),
      subtitle: Text('R\$ ${item.preco.toStringAsFixed(2)}'),
      trailing: Icon(item.precisaAgendar ? Icons.schedule : Icons.fastfood),
      onTap: onTap,
    );
  }
}
