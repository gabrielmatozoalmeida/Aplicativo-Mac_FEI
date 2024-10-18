import 'package:flutter/material.dart';
import '../models/item.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  final VoidCallback onAddToCart;

  ItemCard({required this.item, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(item.name),
        subtitle: Text(item.description),
        trailing: Text('R\$ ${item.price.toStringAsFixed(2)}'),
        onTap: onAddToCart,
      ),
    );
  }
}
