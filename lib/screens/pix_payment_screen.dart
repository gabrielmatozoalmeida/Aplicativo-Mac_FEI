import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PixPaymentScreen extends StatelessWidget {
  const PixPaymentScreen({Key? key}) : super(key: key);

  // Método para gerar um link Pix mais realista
  String generatePixLink() {
    const pixKey = "abc123456789@bank.com"; // Exemplo de chave Pix
    const amount = "25.50"; // Valor do pagamento
    const description = "Pagamento_MacFei";

    return "https://meupix.com.br/pix?key=$pixKey&amount=$amount&desc=$description";
  }

  @override
  Widget build(BuildContext context) {
    final String pixLink = generatePixLink();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagamento com Pix'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pagamento com Pix',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Copie o link abaixo e cole no seu aplicativo bancário para realizar o pagamento:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Clipboard.setData(ClipboardData(text: pixLink));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Link Pix copiado para a área de transferência!'),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        pixLink,
                        style: const TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(Icons.copy, color: Colors.green),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Após confirmar o pagamento, navega para PixSchedulePickupScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PixSchedulePickupScreen(
                      args: {
                        'orderType': 'prato', // Exemplo: tipo do pedido
                        'items': [
                          {'name': 'Prato A', 'prepTime': 10},
                          {'name': 'Prato B', 'prepTime': 5},
                        ], // Lista de itens
                      },
                    ),
                  ),
                );
              },
              child: const Text('Confirmar Pagamento'),
            ),
          ],
        ),
      ),
    );
  }
}

// Renomeada para PixSchedulePickupScreen
class PixSchedulePickupScreen extends StatelessWidget {
  final dynamic args;

  const PixSchedulePickupScreen({Key? key, required this.args}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agendamento')),
      body: Center(
        child: Text(
          'Pedido confirmado e agendado!\n\n'
          'Detalhes: ${args['orderType']} - ${args['items']}',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
