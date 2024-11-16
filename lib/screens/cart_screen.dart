import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final VoidCallback onClearCart; // Função para limpar o carrinho

  const CartScreen({Key? key, required this.cartItems, required this.onClearCart}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late List<Map<String, dynamic>> cartItems;

  @override
  void initState() {
    super.initState();
    // Inicializa o cartItems com o valor recebido da widget
    cartItems = List.from(widget.cartItems);
  }

  void incrementQuantity(int index) {
    setState(() {
      cartItems[index]['quantity']++;
    });
  }

  void decrementQuantity(int index) {
    setState(() {
      if (cartItems[index]['quantity'] > 1) {
        cartItems[index]['quantity']--;
      } else {
        cartItems.removeAt(index); // Remove item se quantidade for 0
      }
      // Se o carrinho estiver vazio, aciona onClearCart
      if (cartItems.isEmpty) {
        widget.onClearCart();
      }
    });
  }

  double getTotal() {
    return cartItems.fold(0, (sum, item) => sum + item['price'] * item['quantity']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text('Seu carrinho está vazio'),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      final totalItemPrice = item['price'] * item['quantity'];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Card(
                          child: ListTile(
                            title: Text('${item['quantity']}x ${item['name']}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item['description'] ?? 'Descrição do item'),
                                const SizedBox(height: 5),
                                Text('Subtotal: R\$ ${totalItemPrice.toStringAsFixed(2)}'),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () => decrementQuantity(index),
                                ),
                                Text('${item['quantity']}'),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () => incrementQuantity(index),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'TOTAL: R\$ ${getTotal().toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/payment');
                    },
                    icon: const Icon(Icons.payment),
                    label: const Text('Pagamento'),
                  ),
                ),
              ],
            ),
    );
  }
}
