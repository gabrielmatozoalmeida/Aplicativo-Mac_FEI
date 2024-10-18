import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Seu carrinho está vazio'),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/payment');
              },
              child: Text('Ir para o Pagamento'),
            ),
          ],
        ),
      ),
    );
  }
}
