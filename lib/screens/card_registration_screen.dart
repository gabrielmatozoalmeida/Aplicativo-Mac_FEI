
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class CardRegistrationScreen extends StatefulWidget {
  const CardRegistrationScreen({Key? key}) : super(key: key);

  @override
  State<CardRegistrationScreen> createState() => _CardRegistrationScreenState();
}

class _CardRegistrationScreenState extends State<CardRegistrationScreen> {
  final MaskedTextController _cardNumberController =
      MaskedTextController(mask: '0000 0000 0000 0000'); // Máscara do número do cartão
  final MaskedTextController _expiryController =
      MaskedTextController(mask: '00/00'); // Máscara para validade MM/AA
  final TextEditingController _cvvController = TextEditingController(); // Campo CVV
  String _cardType = 'Crédito';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Novo Cartão'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _cardType,
              onChanged: (value) {
                setState(() {
                  _cardType = value!;
                });
              },
              items: const [
                DropdownMenuItem(value: 'Crédito', child: Text('Cartão de Crédito')),
                DropdownMenuItem(value: 'Débito', child: Text('Cartão de Débito')),
              ],
              decoration: const InputDecoration(
                labelText: 'Tipo de Cartão',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _cardNumberController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Número do Cartão',
                hintText: 'Ex: 1234 5678 9012 3456',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _expiryController,
              keyboardType: TextInputType.datetime,
              decoration: const InputDecoration(
                labelText: 'Data de Validade',
                hintText: 'MM/AA',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _cvvController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Código de Segurança (CVV)',
                hintText: 'Ex: 123',
              ),
              maxLength: 3, // CVV tem no máximo 3 dígitos
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                if (_cardNumberController.text.isNotEmpty &&
                    _expiryController.text.isNotEmpty &&
                    _cvvController.text.isNotEmpty) {
                  Navigator.pop(context, {
                    'type': _cardType,
                    'number': _cardNumberController.text,
                    'expiry': _expiryController.text,
                    'cvv': _cvvController.text,
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Preencha todos os campos')),
                  );
                }
              },
              child: const Text('Salvar Cartão'),
            ),
          ],
        ),
      ),
    );
  }
}