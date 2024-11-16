import 'item.dart';

class UserOrder {
  final String nome;
  final String tipoUsuario; // Reitor, Professor, Aluno, Funcionario
  final DateTime horarioPedido;
  final List<Item> itens;

  UserOrder({
    required this.nome,
    required this.tipoUsuario,
    required this.horarioPedido,
    required this.itens,
  });
}
