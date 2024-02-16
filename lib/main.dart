import 'package:flutter/material.dart';
import 'package:motivation/screens/quotes.dart';
import 'package:motivation/models/quote.dart';
import 'package:motivation/screens/all_background.dart';
import 'package:motivation/screens/all_fonts.dart';
import 'package:motivation/screens/home.dart';
import 'package:motivation/screens/quotes_controller.dart';
import 'package:provider/provider.dart';
import 'decor_controller.dart';
import 'services/database_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<QuoteController>(
            create: (_) => QuoteController(),
          ),
          ChangeNotifierProvider<DecorController >(
            create: (_) => DecorController(),
          ),
        ],
      builder: (context, child) {
        return MaterialApp(
          title: 'Motivation',
          initialRoute: '/',
          routes: {
            '/': (context) => const Home(),
            '/allbg': (context) => const AllBackground(),
            '/allfonts': (context) => const AllFonts(),
          },
        );
      }
    );
  }
}