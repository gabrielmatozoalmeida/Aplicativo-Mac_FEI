import 'package:flutter/material.dart';

class FilaPrioritaria extends StatelessWidget {
  final String nome;
  final bool prioridade;

  FilaPrioritaria({required this.nome, required this.prioridade});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(nome),
      trailing: prioridade
          ? Icon(Icons.star, color: Colors.orange)
          : Icon(Icons.person),
    );
  }
}
