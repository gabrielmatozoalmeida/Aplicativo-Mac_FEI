import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  final double totalAmount;

  const PaymentScreen({super.key, required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagamento'),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('Pagar com Pix'),
            onTap: () {
              // Redireciona para a tela de pagamento via Pix, passando o valor total
              Navigator.pushNamed(
                context,
                '/pix_payment',
                arguments: totalAmount,
              );
            },
          ),
          ListTile(
            title: const Text('Cadastrar Cartão'),
            onTap: () {
              // Navegar para tela de cadastro de cartão
              Navigator.pushNamed(context, '/card_registration');
            },
          ),
        ],
      ),
    );
  }
}
