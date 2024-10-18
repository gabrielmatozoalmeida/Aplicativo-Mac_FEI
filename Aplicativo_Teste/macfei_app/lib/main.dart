import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/menu_screen.dart';
import 'screens/admin_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/payment_screen.dart';

void main() {
  runApp(MACFEIApp());
}

class MACFEIApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MACFEI',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/menu': (context) => MenuScreen(),
        '/admin': (context) => AdminScreen(),
        '/cart': (context) => CartScreen(),
        '/payment': (context) => PaymentScreen(),
      },
    );
  }
}
