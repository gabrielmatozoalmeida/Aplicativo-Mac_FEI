import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Pratos Prontos'),
            onTap: () {
              // Redireciona para a página de pratos prontos
            },
          ),
          ListTile(
            title: Text('Bebidas'),
            onTap: () {
              // Redireciona para a página de bebidas
            },
          ),
          ListTile(
            title: Text('Pratos a Serem Feitos'),
            onTap: () {
              // Redireciona para a página de pratos a serem feitos
            },
          ),
        ],
      ),
    );
  }
}
