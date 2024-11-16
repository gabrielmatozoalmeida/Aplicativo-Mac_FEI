import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  // Lista de pratos no cardápio
  List<Map<String, dynamic>> menuItems = [
    {'name': 'Lasanha de Queijo', 'price': 15.0, 'category': 'Prato a ser feito', 'prepTime': 20},
    {'name': 'Café com canela', 'price': 20.0, 'category': 'Bebida'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin - Funcionario MACFEI'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Gerenciamento do Cardápio',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ElevatedButton(
            onPressed: () {
              _showDishDialog();
            },
            child: const Text('Cadastrar ou Atualizar Prato'),
          ),
          ElevatedButton(
            onPressed: () {
              _showRemoveDishDialog();
            },
            child: const Text('Remover Prato'),
          ),
          const Divider(),
          const Text(
            'Lista do Cardápio',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ...menuItems.map((item) => ListTile(
                title: Text(item['name']),
                subtitle: Text(
                    'Categoria: ${item['category']} | Preço: R\$ ${item['price'].toStringAsFixed(2)} ${item['category'] == 'Prato a ser feito' ? '| Tempo: ${item['prepTime']} min' : ''}'),
              )),
        ],
      ),
    );
  }

  // Função para adicionar ou atualizar prato
  void _showDishDialog({int? index}) {
    final TextEditingController nameController = TextEditingController(
      text: index != null ? menuItems[index]['name'] : '',
    );
    final TextEditingController priceController = TextEditingController(
      text: index != null ? menuItems[index]['price'].toString() : '',
    );
    final TextEditingController prepTimeController = TextEditingController(
      text: index != null && menuItems[index]['category'] == 'Prato a ser feito'
          ? menuItems[index]['prepTime'].toString()
          : '',
    );

    String selectedCategory =
        index != null ? menuItems[index]['category'] : 'Bebida';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(index != null ? 'Atualizar Prato' : 'Cadastrar Prato'),
          content: StatefulBuilder(
            builder: (context, setState) {
              return SingleChildScrollView(
                child: Column(
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
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
                      ],
                    ),
                    DropdownButtonFormField<String>(
                      value: selectedCategory,
                      items: const [
                        DropdownMenuItem(value: 'Bebida', child: Text('Bebida')),
                        DropdownMenuItem(value: 'Salgado', child: Text('Salgado')),
                        DropdownMenuItem(
                            value: 'Prato a ser feito', child: Text('Prato a ser feito')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value!;
                        });
                      },
                      decoration: const InputDecoration(labelText: 'Categoria'),
                    ),
                    if (selectedCategory == 'Prato a ser feito')
                      TextField(
                        controller: prepTimeController,
                        decoration:
                            const InputDecoration(labelText: 'Tempo de Preparo (min)'),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                  ],
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                final newDish = {
                  'name': nameController.text,
                  'price': double.parse(priceController.text),
                  'category': selectedCategory,
                  if (selectedCategory == 'Prato a ser feito')
                    'prepTime': int.parse(prepTimeController.text),
                };

                setState(() {
                  if (index != null) {
                    menuItems[index] = newDish;
                  } else {
                    menuItems.add(newDish);
                  }
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
                    Navigator.pop(context);
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
}
