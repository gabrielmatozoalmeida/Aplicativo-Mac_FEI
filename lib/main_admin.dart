import 'package:flutter/material.dart';
import 'screens/admin_screen.dart';
import 'screens/menu_screen.dart';
import 'screens/queue_management_screen.dart'; // Import da tela de gerenciamento de filas

void main() {
  runApp(const MACFEIAdminApp());
}

class MACFEIAdminApp extends StatelessWidget {
  const MACFEIAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MACFEI - Admin',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const AdminScreen(), // Tela inicial para o admin
        '/menu': (context) => const MenuScreen(),
        // Adiciona uma rota para a tela de gerenciamento de filas
        '/queueManagement': (context) => QueueManagementScreen(orders: []),
      },
    );
  }
}
