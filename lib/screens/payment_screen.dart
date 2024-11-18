import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int selectedInstallment = 1;
  double totalAmount = 12.0; // Valor total da compra
  bool isCardRegistered = false; // Indica se o cartão foi cadastrado
  bool isCreditCard = true; // Indica o tipo de cartão (crédito ou débito)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagamento'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                PaymentOption(
                  icon: Icons.qr_code,
                  title: 'Pagar com Pix',
                  onTap: () {
                    Navigator.pushNamed(context, '/pix_payment');
                  },
                ),
                PaymentOption(
                  icon: Icons.credit_card,
                  title: 'Cadastrar Cartão',
                  onTap: () {
                    Navigator.pushNamed(context, '/card_registration').then((_) {
                      // Simula que o cartão foi cadastrado
                      setState(() {
                        isCardRegistered = true;
                      });
                    });
                  },
                ),
                if (isCardRegistered)
                  PaymentOption(
                    icon: Icons.credit_card,
                    title: 'Cartão Cadastrado',
                    onTap: () {
                      _showCardPaymentDialog(context);
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showCardPaymentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pagamento com Cartão'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isCreditCard) const Text('Selecione o número de parcelas:'),
              if (isCreditCard && totalAmount > 10)
                DropdownButton<int>(
                  value: selectedInstallment,
                  items: _generateInstallments(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedInstallment = value;
                      });
                    }
                  },
                ),
              if (!isCreditCard)
                const Text(
                  'Pagamento será realizado no débito (à vista).',
                  style: TextStyle(fontSize: 16),
                ),
              if (isCreditCard && totalAmount <= 10)
                const Text(
                  'Parcelamento disponível apenas para valores acima de R\$ 10.',
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _showErrorDialog(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _showSuccessDialog(context);
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  List<DropdownMenuItem<int>> _generateInstallments() {
    if (!isCreditCard || totalAmount <= 10) {
      // Se não for crédito ou o valor for menor que 10, não permite parcelamento.
      return [];
    }

    // A cada R$ 10 acima de R$ 10, aumenta em duas parcelas.
    int maxInstallments = 2; // Inicia com 2 parcelas para o mínimo de R$ 10
    double additionalInstallments = (totalAmount - 10) / 10;
    maxInstallments += (additionalInstallments.floor() * 2);

    // Limita a 12 parcelas como padrão.
    maxInstallments = maxInstallments.clamp(2, 12);

    return List.generate(maxInstallments, (index) {
      final parcelas = index + 1; // Número de parcelas começa de 1
      final parcelaValor = (totalAmount / parcelas).toStringAsFixed(2);
      return DropdownMenuItem(
        value: parcelas,
        child: Text('$parcelas parcelas - R\$ $parcelaValor'),
      );
    });
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Pagamento Concluído',
            style: TextStyle(color: Colors.green), // Título em verde
          ),
          content: const Text('Seu pedido foi pago com sucesso.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(
                  context,
                  '/schedule_pickup',
                  arguments: {
                    'orderType': 'prato', // Exemplo: Tipo do pedido
                    'isReady': false,     // Exemplo: Pedido ainda em preparo
                  },
                );
              },
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Pagamento Cancelado',
            style: TextStyle(color: Colors.red), // Título em vermelho
          ),
          content: const Text('O pagamento não foi realizado.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }
}

class PaymentOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const PaymentOption({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(icon, size: 32),
        title: Text(title, style: const TextStyle(fontSize: 18)),
        onTap: onTap,
      ),
    );
  }
}
