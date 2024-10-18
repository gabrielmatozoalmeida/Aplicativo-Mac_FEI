import 'package:flutter/material.dart';

class AdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem-vindo, Funcionario MACFEI'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              // Ação para adicionar um novo prato
            },
            child: Text('Cadastrar Prato'),
          ),
          ElevatedButton(
            onPressed: () {
              // Ação para atualizar o cardápio
            },
            child: Text('Atualizar Cardápio'),
          ),
          ElevatedButton(
            onPressed: () {
              // Ação para remover pratos
            },
            child: Text('Remover Prato'),
          ),
          ElevatedButton(
            onPressed: () {
              // Ação para gerenciar pedidos
            },
            child: Text('Gerenciar Pedidos'),
          ),
        ],
      ),
    );
  }
}
