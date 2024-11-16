import 'package:flutter/material.dart';

class UserTypeScreen extends StatelessWidget {
  const UserTypeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecione seu tipo de usuário'),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('Aluno'),
            onTap: () {
              Navigator.pushNamed(context, '/menu', arguments: 'Aluno');
            },
          ),
          ListTile(
            title: const Text('Funcionário'),
            onTap: () {
              Navigator.pushNamed(context, '/menu', arguments: 'Funcionário');
            },
          ),
          ListTile(
            title: const Text('Professor'),
            onTap: () {
              Navigator.pushNamed(context, '/menu', arguments: 'Professor');
            },
          ),
          ListTile(
            title: const Text('Reitor'),
            onTap: () {
              Navigator.pushNamed(context, '/menu', arguments: 'Reitor');
            },
          ),
        ],
      ),
    );
  }
}
