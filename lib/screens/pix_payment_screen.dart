import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PixPaymentScreen extends StatelessWidget {
  const PixPaymentScreen({Key? key}) : super(key: key);

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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PixSchedulePickupScreen(
                      args: {
                        'orderType': 'prato', // Exemplo: tipo do pedido
                        'items': [
                          {'name': 'Salgado', 'prepTime': 0, 'isReady': true},
                          {'name': 'Prato Feito', 'prepTime': 15, 'isReady': false},
                          {'name': 'Bebida', 'prepTime': 0, 'isReady': true},
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

class PixSchedulePickupScreen extends StatelessWidget {
  final dynamic args;

  const PixSchedulePickupScreen({Key? key, required this.args}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List items = args['items'];

    return Scaffold(
      appBar: AppBar(title: const Text('Status do Pedido')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Histórico de Pedidos',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  final bool isReady = item['isReady'] ?? false;

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(item['name']),
                      subtitle: isReady
                          ? const Text(
                              'Pronto para retirada',
                              style: TextStyle(color: Colors.green),
                            )
                          : Text(
                              'Tempo de preparo: ${item['prepTime']} minutos',
                              style: const TextStyle(color: Colors.orange),
                            ),
                      trailing: isReady
                          ? const Icon(Icons.check_circle, color: Colors.green)
                          : const Icon(Icons.timer, color: Colors.orange),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
