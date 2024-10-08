enum TipoUsuario{
  aluno,
  professor,
  reitor,
}

class Usuario {
  final String nome;
  final TipoUsuario tipo;

  Usuario({
    required this.nome,
    required this.tipo,
  });
}