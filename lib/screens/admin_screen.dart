import 'package:flutter/material.dart';
import 'queue_management_screen.dart'; // Substitua 'seu_projeto' pelo nome real do seu pacote.

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  // Lista de categorias para os itens do cardápio
  final List<String> categories = ['Bebidas', 'Pratos a Fazer', 'Salgados'];

  // Lista de pratos no cardápio com categoria e tempo de preparo
  List<Map<String, dynamic>> menuItems = [
    {'name': 'Prato 1', 'price': 15.0, 'category': 'Pratos a Fazer', 'prepTime': 15},
    {'name': 'Prato 2', 'price': 20.0, 'category': 'Pratos a Fazer', 'prepTime': 20},
    {'name': 'Bebida 1', 'price': 5.0, 'category': 'Bebidas', 'prepTime': 2},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin - Funcionario MACFEI'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Gerenciamento do Cardápio',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildButton(
              icon: Icons.add,
              label: 'Cadastrar Prato',
              color: Colors.green,
              onPressed: _showAddDishDialog,
            ),
            const SizedBox(height: 10),
            _buildButton(
              icon: Icons.update,
              label: 'Atualizar Cardápio',
              color: Colors.blue,
              onPressed: _showUpdateMenuDialog,
            ),
            const SizedBox(height: 10),
            _buildButton(
              icon: Icons.delete,
              label: 'Remover Prato',
              color: Colors.red,
              onPressed: _showRemoveDishDialog,
            ),
            const Divider(height: 40, thickness: 2),
            const Text(
              'Gerenciamento de Pedidos',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildButton(
              icon: Icons.assignment,
              label: 'Gerenciar Pedidos',
              color: Colors.orange,
              onPressed: _navigateToQueueManagementScreen,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      icon: Icon(icon, size: 20),
      label: Text(label, style: const TextStyle(fontSize: 16)),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onPressed,
    );
  }

  
  void _navigateToQueueManagementScreen() {
  // Exemplo de lista de pedidos fictícios (substitua pelos dados reais)
  List<Map<String, dynamic>> orders = [
    {'id': 1, 'item': 'Prato 1', 'prepTime': 15, 'status': 'Pendente'},
    {'id': 2, 'item': 'Prato 2', 'prepTime': 10, 'status': 'Pendente'},
    {'id': 3, 'item': 'Bebida 1', 'prepTime': 5, 'status': 'Pendente'},
  ];

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => QueueManagementScreen(orders: orders),
    ),
  );
}

  // Função para exibir um diálogo de adicionar prato
  void _showAddDishDialog() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    final TextEditingController prepTimeController = TextEditingController();
    String selectedCategory = categories.first;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Cadastrar Prato'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nome do Prato',
                    icon: Icon(Icons.restaurant),
                  ),
                ),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(
                    labelText: 'Preço (R\$)',
                    icon: Icon(Icons.attach_money),
                  ),
                  keyboardType: TextInputType.number,
                ),
                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value!;
                    });
                  },
                  items: categories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    labelText: 'Categoria',
                    icon: Icon(Icons.category),
                  ),
                ),
                TextField(
                  controller: prepTimeController,
                  decoration: const InputDecoration(
                    labelText: 'Tempo de Preparo (minutos)',
                    icon: Icon(Icons.timer),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  menuItems.add({
                    'name': nameController.text,
                    'price': double.parse(priceController.text),
                    'category': selectedCategory,
                    'prepTime': int.parse(prepTimeController.text),
                  });
                });
                Navigator.pop(context);
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  // Função para exibir o cardápio e permitir atualizações
  void _showUpdateMenuDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Atualizar Cardápio'),
          content: ListView.builder(
            shrinkWrap: true,
            itemCount: menuItems.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(menuItems[index]['name']),
                subtitle: Text(
                    'R\$ ${menuItems[index]['price']} | Categoria: ${menuItems[index]['category']} | Preparo: ${menuItems[index]['prepTime']} min'),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    _editDishDialog(index);
                  },
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  // Função para remover um prato
  void _showRemoveDishDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Remover Prato'),
          content: ListView.builder(
            shrinkWrap: true,
            itemCount: menuItems.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(menuItems[index]['name']),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      menuItems.removeAt(index);
                    });
                  },
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  // Função para editar um prato
  void _editDishDialog(int index) {
    final TextEditingController nameController =
        TextEditingController(text: menuItems[index]['name']);
    final TextEditingController priceController =
        TextEditingController(text: menuItems[index]['price'].toString());
    final TextEditingController prepTimeController =
        TextEditingController(text: menuItems[index]['prepTime'].toString());
    String selectedCategory = menuItems[index]['category'];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar Prato'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nome do Prato'),
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Preço (R\$)'),
                keyboardType: TextInputType.number,
              ),
              DropdownButtonFormField<String>(
                value: selectedCategory,
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value!;
                  });
                },
                items: categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                decoration:
                    const InputDecoration(labelText: 'Categoria'),
              ),
              TextField(
                controller: prepTimeController,
                decoration: const InputDecoration(
                    labelText: 'Tempo de Preparo (minutos)'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  menuItems[index] = {
                    'name': nameController.text,
                    'price': double.parse(priceController.text),
                    'category': selectedCategory,
                    'prepTime': int.parse(prepTimeController.text),
                  };
                });
                Navigator.pop(context);
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }
}
