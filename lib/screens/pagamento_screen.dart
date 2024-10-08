import 'package:flutter/material.dart';

class PagamentoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pagamento')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                // Implementar lógica de pagamento via PIX
              },
              child: Text('Pagar com PIX'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implementar lógica de pagamento com cartão
              },
              child: Text('Pagar com Cartão'),
            ),
          ],
        ),
      ),
    );
  }
}
