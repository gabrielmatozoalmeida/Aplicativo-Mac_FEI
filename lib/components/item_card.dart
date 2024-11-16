import 'package:flutter/material.dart';
import '../models/item.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  final VoidCallback onAddToCart;

  const ItemCard({super.key, required this.item, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(item.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.description),
            if (item.type == "Prato a Ser Feito" && item.preparationTime != null)
              Text("Tempo de preparo: aproximadamente ${item.preparationTime} min"),
          ],
        ),
        trailing: Text('R\$ ${item.price.toStringAsFixed(2)}'),
        onTap: onAddToCart,
      ),
    );
  }
}
