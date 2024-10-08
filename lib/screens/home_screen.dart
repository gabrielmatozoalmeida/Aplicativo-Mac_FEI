import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Aplicativo MacFEI')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/cardapio');
              },
              child: Text('Ver Cardápio'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/pagamento');
              },
              child: Text('Pagamento'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/gerenciamento');
              },
              child: Text('Gerenciamento de Pedidos'),
            ),
          ],
        ),
      ),
    );
  }
}
