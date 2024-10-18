import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagamento'),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Pagar com Pix'),
            onTap: () {
              // Chamar API de pagamento via Pix
            },
          ),
          ListTile(
            title: Text('Cadastrar Cartão'),
            onTap: () {
              // Navegar para tela de cadastro de cartão
            },
          ),
        ],
      ),
    );
  }
}
