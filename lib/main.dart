import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/cardapio_screen.dart';
import 'screens/pagamento_screen.dart';
import 'screens/horario_screen.dart';
import 'screens/gerenciamento_screen.dart';
import 'screens/qrcode_screen.dart';
import 'models/cardapio.dart';

void main() {
  runApp(RestaurantApp());
}

class RestaurantApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurante MACFEI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/cardapio': (context) => CardapioScreen(),
        '/pagamento': (context) => PagamentoScreen(),
        '/horario': (context) => HorarioScreen(),
        '/gerenciamento': (context) => GerenciamentoScreen(),
      },
      onGenerateRoute: (settings) {
        // Geração dinâmica de QR Code, recebendo os dados de pagamento
        if (settings.name == '/qrcode') {
          final String qrData = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) {
              return QRCodeScreen(qrData: qrData);
            },
          );
        }
        return null;
      },
    );
  }
}
