import 'package:flutter/material.dart';
import 'cart_screen.dart';
import 'payment_screen.dart';
import 'welcome_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final List<Map<String, dynamic>> items = [
    // Salgados
    {'name': 'Coxinha', 'description': 'Coxinha de frango com catupiry', 'price': 6.00, 'type': 'Salgado'},
    {'name': 'Empada de Palmito', 'description': 'Empada recheada com palmito e azeitonas', 'price': 5.00, 'type': 'Salgado'},
    {'name': 'Pastel de Carne', 'description': 'Pastel recheado com carne moída e temperos', 'price': 4.50, 'type': 'Salgado'},
    {'name': 'Quibe', 'description': 'Quibe de carne com hortelã', 'price': 4.00, 'type': 'Salgado'},
    {'name': 'Esfiha de Carne', 'description': 'Esfiha aberta de carne com temperos especiais', 'price': 3.50, 'type': 'Salgado'},

    // Bebidas
    {'name': 'Suco de Laranja', 'description': 'Suco natural de laranja', 'price': 5.00, 'type': 'Bebida'},
    {'name': 'Refrigerante', 'description': 'Refrigerante de cola, 350ml', 'price': 4.00, 'type': 'Bebida'},
    {'name': 'Água Mineral', 'description': 'Água mineral sem gás, 500ml', 'price': 3.00, 'type': 'Bebida'},
    {'name': 'Café Expresso', 'description': 'Café expresso tradicional', 'price': 3.50, 'type': 'Bebida'},
    {'name': 'Chá Gelado', 'description': 'Chá gelado de limão com hortelã', 'price': 4.50, 'type': 'Bebida'},
    
    // Pratos a Serem Feitos
    {'name': 'Lasanha', 'description': 'Lasanha de carne com molho de tomate e queijo', 'price': 20.00, 'type': 'Prato a Ser Feito', 'preparationTime': 25},
    {'name': 'Espaguete à Bolonhesa', 'description': 'Espaguete com molho bolonhesa e queijo parmesão', 'price': 22.00, 'type': 'Prato a Ser Feito', 'preparationTime': 20},
    {'name': 'Risoto de Cogumelos', 'description': 'Risoto de cogumelos frescos e parmesão', 'price': 25.00, 'type': 'Prato a Ser Feito', 'preparationTime': 30},
  ];

  final Map<String, int> itemQuantities = {};
  List<Map<String, dynamic>> cartItems = [];
  String selectedCategory = 'Salgado';

  double getTotalPrice() {
    return cartItems.fold(0, (total, item) => total + (item['price'] * item['quantity']));
  }

  void incrementQuantity(String itemName) {
    setState(() {
      itemQuantities[itemName] = (itemQuantities[itemName] ?? 0) + 1;
    });
  }

  void decrementQuantity(String itemName) {
    setState(() {
      final currentQuantity = itemQuantities[itemName] ?? 0;
      if (currentQuantity > 0) {
        itemQuantities[itemName] = currentQuantity - 1;
      }
    });
  }

  void addToCart(String itemName) {
    setState(() {
      var existingItem = cartItems.firstWhere(
        (item) => item['name'] == itemName,
        orElse: () => {},
      );

      if (existingItem.isNotEmpty) {
        existingItem['quantity'] += itemQuantities[itemName]!;
      } else {
        var item = items.firstWhere((element) => element['name'] == itemName);
        cartItems.add({
          'name': itemName,
          'quantity': itemQuantities[itemName]!,
          'price': item['price'],
          'description': item['description']
        });
      }
      itemQuantities[itemName] = 0;
    });
  }

  void clearCart() {
    setState(() {
      cartItems.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(
                        cartItems: cartItems,
                        onClearCart: clearCart,
                      ),
                    ),
                  );
                  setState(() {});
                },
              ),
              if (cartItems.isNotEmpty)
                Positioned(
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${cartItems.length}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Salgados'),
              onTap: () {
                setState(() {
                  selectedCategory = 'Salgado';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Pratos a Serem Feitos'),
              onTap: () {
                setState(() {
                  selectedCategory = 'Prato a Ser Feito';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Bebidas'),
              onTap: () {
                setState(() {
                  selectedCategory = 'Bebida';
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: ListView(
        children: items
            .where((item) => item['type'] == selectedCategory)
            .map((item) => _buildItemTile(item))
            .toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue.shade900,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white,
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const WelcomeScreen()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MenuScreen()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PaymentScreen()),
            );
          }
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Página Inicial',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.menu, size: 32),
            label: 'Menu',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Pagamento',
          ),
        ],
      ),
    );
  }

  Widget _buildItemTile(Map<String, dynamic> item) {
    return ListTile(
      title: Text(item['name']),
      subtitle: Text(item['description']),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () => decrementQuantity(item['name']),
          ),
          Text('${itemQuantities[item['name']] ?? 0}'),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => incrementQuantity(item['name']),
          ),
          if ((itemQuantities[item['name']] ?? 0) > 0)
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                addToCart(item['name']);
              },
            ),
        ],
      ),
    );
  }
}