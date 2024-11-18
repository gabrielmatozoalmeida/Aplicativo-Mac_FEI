import 'package:flutter/material.dart';
import 'screens/admin_screen.dart';
import 'screens/menu_screen.dart';
import 'screens/queue_management_screen.dart';

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
        // Removido `const` porque AdminScreen é um StatefulWidget
        '/': (context) => AdminScreen(),
        '/menu': (context) => const MenuScreen(),
        '/queueManagement': (context) => QueueManagementScreen(
              orders: []),
      },
    );
  }
}
