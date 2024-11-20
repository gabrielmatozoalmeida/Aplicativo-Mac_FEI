import 'package:flutter/material.dart';
// Renomear a importação para evitar conflitos
import 'package:macfei_app/screens/card_registration_screen.dart' as cardRegistration;

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final List<Map<String, dynamic>> registeredCards = []; // Lista de cartões cadastrados
  int? selectedCardIndex; // Índice do cartão selecionado

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleção de Pagamento'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  if (registeredCards.isEmpty)
                    const Text(
                      'Nenhum cartão cadastrado ainda.',
                      style: TextStyle(fontSize: 16),
                    ),
                  if (registeredCards.isNotEmpty)
                    const Text(
                      'Selecione um cartão:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ...registeredCards.asMap().entries.map(
                    (entry) {
                      final index = entry.key;
                      final card = entry.value;
                      return RadioListTile<int>(
                        value: index,
                        groupValue: selectedCardIndex,
                        onChanged: (value) {
                          setState(() {
                            selectedCardIndex = value;
                          });
                        },
                        title: Text(
                            '${card['type']} - Final ${card['number'].substring(card['number'].length - 4)}'),
                        subtitle: Text(
                            'Validade: ${card['expiry']} | CVV: ${card['cvv']}'),
                        secondary: const Icon(Icons.credit_card),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    final newCard = await Navigator.push<Map<String, dynamic>>(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const cardRegistration.CardRegistrationScreen()),
                    );
                    if (newCard != null) {
                      setState(() {
                        registeredCards.add(newCard);
                      });
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Cadastrar Novo Cartão'),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: selectedCardIndex == null
                      ? null
                      : () {
                          _confirmPayment(context, registeredCards[selectedCardIndex!]);
                        },
                  icon: const Icon(Icons.payment),
                  label: const Text('Pagar com Cartão Selecionado'),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/pix_payment');
                  },
                  icon: const Icon(Icons.qr_code),
                  label: const Text('Pagar com PIX'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _confirmPayment(BuildContext context, Map<String, dynamic> card) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Pagamento com ${card['type']}'),
          content: Text(
              'Deseja realizar o pagamento com o cartão de número final ${card['number'].substring(card['number'].length - 4)}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Cancela e fecha o diálogo
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Fecha o diálogo
                _processPayment(context, card); // Processa o pagamento e redireciona
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  void _processPayment(BuildContext context, Map<String, dynamic> card) {
    // Exibe a notificação de sucesso
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Pagamento realizado com sucesso!',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2), // A mensagem será exibida por 2 segundos
      ),
    );

    // Redireciona para a tela '/schedule_pickup' com informações do pedido
    Navigator.pushNamed(
      context,
      '/schedule_pickup',
      arguments: {
        'orderDetails': {
          'paymentMethod': card['type'],
          'lastDigits': card['number'].substring(card['number'].length - 4),
          'status': 'Pago',
        },
      },
    );
  }
}
