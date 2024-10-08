import 'package:flutter/material.dart';

class GerenciamentoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gerenciamento de Pedidos')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              // Implementar ação para atualizar cardápio
            },
            child: Text('Atualizar Cardápio'),
          ),
          ElevatedButton(
            onPressed: () {
              // Implementar ação para ver pedidos
            },
            child: Text('Ver Pedidos'),
          ),
          ElevatedButton(
            onPressed: () {
              // Implementar lógica para escanear QR code
            },
            child: Text('Escanear QR Code'),
          ),
        ],
      ),
    );
  }
}
