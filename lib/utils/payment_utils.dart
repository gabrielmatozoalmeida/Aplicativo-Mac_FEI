class PaymentUtils {
  static bool validarCartao(String numeroCartao, String validade, String cvv) {
    // Lógica simples de validação (validação real envolve mais detalhes)
    if (numeroCartao.length == 16 && validade.length == 5 && cvv.length == 3) {
      return true;
    }
    return false;
  }

  static String gerarPixQrCode(String chavePix, double valor) {
    // Gera o código QR para pagamento via PIX (simulação)
    return 'pix:$chavePix?valor=$valor';
  }
}
