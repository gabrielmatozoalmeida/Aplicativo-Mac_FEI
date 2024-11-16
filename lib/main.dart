import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/menu_screen.dart';
import 'screens/admin_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/payment_screen.dart';
import 'screens/user_type_screen.dart';
import 'screens/pix_payment_screen.dart';
import 'screens/schedule_pickup_screen.dart';
import 'screens/card_registration_screen.dart';

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
        '/welcome': (context) => const WelcomeScreen(),
        '/menu': (context) => const MenuScreen(),
        '/': (context) => const AdminScreen(),
        '/payment': (context) => const PaymentScreen(),
        '/pix_payment': (context) => const PixPaymentScreen(),
        '/user_type': (context) => const UserTypeScreen(),
        '/card_registration': (context) => CardRegistrationScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/cart') {
          final Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
          final cartItems = args['cartItems'] as List<Map<String, dynamic>>;
          final onClearCart = args['onClearCart'] as VoidCallback;

          return MaterialPageRoute(
            builder: (context) => CartScreen(
              cartItems: cartItems,
              onClearCart: onClearCart,
            ),
          );
        } else if (settings.name == '/schedule_pickup') {
          // Argumentos esperados para a tela SchedulePickupScreen
          final Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
          final String orderType = args['orderType'] as String;
          final bool isReady = args['isReady'] as bool;

          return MaterialPageRoute(
            builder: (context) => SchedulePickupScreen(
              orderType: orderType,
              isReady: isReady,
            ),
          );
        }
        return null; // Retorna nulo para rotas desconhecidas
      },
    );
  }
}