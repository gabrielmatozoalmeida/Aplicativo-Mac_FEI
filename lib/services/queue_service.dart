import '../models/user_order.dart';

class QueueService {
  List<UserOrder> fila = [];

  void adicionarPedido(UserOrder pedido) {
    fila.add(pedido);
    fila.sort((a, b) {
      if (a.tipoUsuario == b.tipoUsuario) {
        return a.horarioPedido.compareTo(b.horarioPedido);
      }
      return _prioridadeTipoUsuario(a.tipoUsuario) - _prioridadeTipoUsuario(b.tipoUsuario);
    });
  }

  List<UserOrder> listarFila() {
    return fila;
  }

  int _prioridadeTipoUsuario(String tipoUsuario) {
    switch (tipoUsuario) {
      case 'Reitor':
        return 1;
      case 'Professor':
        return 2;
      case 'Funcionario':
        return 3;
      case 'Aluno':
      default:
        return 4;
    }
  }
}
