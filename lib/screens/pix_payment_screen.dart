import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PixPaymentScreen extends StatelessWidget {
  const PixPaymentScreen({Key? key}) : super(key: key);

  // Método para gerar um link Pix com um código de exemplo
  String generatePixLink() {
    return "https://bank.com/pix?code=PIX123456789";
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
                        style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
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
                Navigator.pop(context, 'Pagamento Iniciado');
              },
              child: const Text('Confirmar Pagamento'),
            ),
          ],
        ),
      ),
    );
  }
}
