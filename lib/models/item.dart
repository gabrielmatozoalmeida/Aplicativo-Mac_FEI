class Item {
  final String name;
  final String description;
  final double price;
  final String type; // Pode ser "Prato Feito", "Bebida" ou "Prato a Ser Feito"
  final int? preparationTime; // Tempo de preparo em minutos, se aplicável

  Item({
    required this.name,
    required this.description,
    required this.price,
    required this.type,
    this.preparationTime,
  });
}

final items = [
  Item(
    name: 'Prato Feito - Feijoada',
    description: 'Feijoada completa com arroz, farofa e couve',
    price: 15.00,
    type: 'Prato Feito',
  ),
  Item(
    name: 'Bebida - Suco de Laranja',
    description: 'Suco natural de laranja',
    price: 5.00,
    type: 'Bebida',
  ),
  Item(
    name: 'Prato a Ser Feito - Lasanha',
    description: 'Lasanha de carne com molho de tomate e queijo',
    price: 20.00,
    type: 'Prato a Ser Feito',
    preparationTime: 25,
  ),
];

