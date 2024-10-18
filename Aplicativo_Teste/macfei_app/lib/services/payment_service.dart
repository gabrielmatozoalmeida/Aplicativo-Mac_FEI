import 'package:http/http.dart' as http;

class PaymentService {
  Future<void> realizarPagamentoPix(double valor) async {
    // Aqui você faria a chamada para a API de pagamento Pix
    final response = await http.post(
      Uri.parse('https://api.pagamento.com/pix'),
      body: {'valor': valor.toString()},
    );

    if (response.statusCode == 200) {
      // Pagamento com sucesso
    } else {
      // Tratamento de erro no pagamento
    }
  }

  Future<void> cadastrarCartao(String numeroCartao, String validade, String cvv) async {
    // Aqui você faria a chamada para a API de cadastro de cartão
    final response = await http.post(
      Uri.parse('https://api.pagamento.com/cartao'),
      body: {
        'numeroCartao': numeroCartao,
        'validade': validade,
        'cvv': cvv,
      },
    );

    if (response.statusCode == 200) {
      // Cartão cadastrado com sucesso
    } else {
      // Tratamento de erro
    }
  }
}
