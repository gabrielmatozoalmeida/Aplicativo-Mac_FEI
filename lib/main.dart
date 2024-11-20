import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/menu_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/payment_screen.dart';
import 'screens/user_type_screen.dart';
import 'screens/pix_payment_screen.dart';
import 'screens/card_registration_screen.dart';
import 'screens/schedule_pickup_screen.dart';

void main() {
  runApp(const MACFEIApp());
}

class MACFEIApp extends StatelessWidget {
  const MACFEIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MACFEI',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/menu': (context) => const MenuScreen(),
        '/payment': (context) => const PaymentScreen(),
        '/pix_payment': (context) => const PixPaymentScreen(),
        '/user_type': (context) => const UserTypeScreen(),
        '/card_registration': (context) => const CardRegistrationScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/cart') {
          final args = settings.arguments as Map<String, dynamic>;
          final cartItems = args['cartItems'] as List<Map<String, dynamic>>;
          final onClearCart = args['onClearCart'] as VoidCallback;

          return MaterialPageRoute(
            builder: (context) => CartScreen(
              cartItems: cartItems,
              onClearCart: onClearCart,
            ),
          );
        } else if (settings.name == '/schedule_pickup') {
          // Passa os argumentos para a tela
          final args = settings.arguments as Map<String, dynamic>? ?? {};
          return MaterialPageRoute(
            builder: (context) => SchedulePickupScreen(args: args),
          );
        }
        return null; // Retorna nulo para rotas desconhecidas
      },
    );
  }
}
