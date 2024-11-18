import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CardRegistrationScreen extends StatelessWidget {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  String _selectedCardType = 'Crédito';

  CardRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Cartão'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _selectedCardType,
              items: const [
                DropdownMenuItem(value: 'Crédito', child: Text('Cartão de Crédito')),
                DropdownMenuItem(value: 'Débito', child: Text('Cartão de Débito')),
              ],
              onChanged: (value) {
                _selectedCardType = value ?? 'Crédito';
              },
              decoration: const InputDecoration(labelText: 'Tipo de Cartão'),
            ),
            TextField(
              controller: _cardNumberController,
              decoration: const InputDecoration(labelText: 'Número do Cartão'),
              keyboardType: TextInputType.number,
              maxLength: 19,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                _CardNumberInputFormatter(),
              ],
            ),
            TextField(
              controller: _expiryDateController,
              decoration: const InputDecoration(labelText: 'Validade (MM/AA)'),
              keyboardType: TextInputType.number,
              maxLength: 5,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                _ExpiryDateInputFormatter(),
              ],
            ),
            TextField(
              controller: _cvvController,
              decoration: const InputDecoration(labelText: 'CVV'),
              keyboardType: TextInputType.number,
              maxLength: 3,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final currentDate = DateTime.now();
                final expiryDate = _expiryDateController.text;

                if (expiryDate.length == 5) {
                  final month = int.tryParse(expiryDate.substring(0, 2));
                  final year = int.tryParse('20' + expiryDate.substring(3, 5));

                  if (month != null && year != null) {
                    if (year > currentDate.year || (year == currentDate.year && month >= currentDate.month)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Cartão cadastrado com sucesso!')),
                      );
                      Navigator.pop(context, true);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Data de validade inválida.')),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Formato de data inválido.')),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Formato de data inválido.')),
                  );
                }
              },
              child: const Text('Cadastrar Cartão'),
            ),
          ],
        ),
      ),
    );
  }
}

// Formatação do número do cartão para o padrão XXXX XXXX XXXX XXXX
class _CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text.replaceAll(' ', '');
    String formatted = '';
    for (int i = 0; i < newText.length; i++) {
      if (i % 4 == 0 && i != 0) formatted += ' ';
      formatted += newText[i];
    }
    return newValue.copyWith(text: formatted, selection: TextSelection.collapsed(offset: formatted.length));
  }
}

// Formatação da validade para o padrão MM/AA
class _ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text.replaceAll('/', '');
    String formatted = '';
    for (int i = 0; i < newText.length; i++) {
      if (i == 2) formatted += '/';
      formatted += newText[i];
    }
    return newValue.copyWith(text: formatted, selection: TextSelection.collapsed(offset: formatted.length));
  }
}
