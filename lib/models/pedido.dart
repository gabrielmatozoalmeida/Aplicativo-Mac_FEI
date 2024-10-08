class Pedido {
  final String id;
  final String nomeCliente;
  final String itemCardapio;
  final bool prioridade; // Prioridade para professores / reitores
  final DateTime horarioRetirada;
  final bool pronto;

  Pedido({
    required this.id,
    required this.nomeCliente,
    required this.itemCardapio,
    this.prioridade = false,
    required this.horarioRetirada,
    this.pronto = false,
  });
}