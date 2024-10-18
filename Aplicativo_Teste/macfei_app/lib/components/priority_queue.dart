class Pedido {
  final String nome;
  final String tipoUsuario; // Reitor, Professor, Aluno, Funcionario
  final DateTime horarioPedido;

  Pedido(this.nome, this.tipoUsuario, this.horarioPedido);

  int get prioridade {
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

class FilaPedidos {
  List<Pedido> pedidos = [];

  void adicionarPedido(Pedido pedido) {
    pedidos.add(pedido);
    pedidos.sort((a, b) {
      if (a.prioridade == b.prioridade) {
        return a.horarioPedido.compareTo(b.horarioPedido);
      }
      return a.prioridade.compareTo(b.prioridade);
    });
  }

  List<Pedido> listarPedidos() {
    return pedidos;
  }
}
