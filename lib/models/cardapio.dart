class ItemCardapio{
  final String id;
  final String nome;
  final double preco;
  final bool precisaAgendar; // Se o prato precisa de agendamento para ser preparado

  ItemCardapio({
    required this.id,
    required this.nome,
    required this.preco,
    this.precisaAgendar  = false,
  });
}