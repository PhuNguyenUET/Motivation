import 'package:flutter/material.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:motivation/models/quote.dart';
import 'package:motivation/screens/add_quotes_screen.dart';
import 'package:motivation/screens/all_background.dart';
import 'package:motivation/screens/all_fonts.dart';
import 'package:motivation/screens/home.dart';
import 'package:motivation/screens/loading_screen.dart';
import 'package:motivation/screens/quotes_controller.dart';
import 'package:motivation/screens/reminder_screen_controller.dart';
import 'package:motivation/screens/reminders_screen.dart';
import 'package:motivation/services/NotificationBackend/NotificationController.dart';
import 'package:motivation/services/post_notification_service.dart';
import 'package:provider/provider.dart';
import 'screens/user_controller.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  tz.initializeTimeZones();
  final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(currentTimeZone));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < 20; i++) {
      precacheImage(AssetImage(
        'assets/wallpaper_$i.jpg'
      ), context);
    }
    final ThemeData themeData = ThemeData(
        useMaterial3: true,
        brightness: Brightness.light);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<QuoteController>(
            create: (_) => QuoteController(),
          ),
          ChangeNotifierProvider<DecorController >(
            create: (_) => DecorController(),
          ),
          ChangeNotifierProvider<ReminderController >(
            create: (_) => ReminderController(),
          ),
        ],
      builder: (context, child) {
        return MaterialApp(
          theme: themeData,
          title: 'Motivation',
          initialRoute: '/',
          routes: {
            '/': (context) => const Home(),
            '/allbg': (context) => const AllBackground(),
            '/allfonts': (context) => const AllFonts(),
            '/quotesadd': (context) => const QuotesAddition(),
            '/reminders': (context) => const ReminderScreen(),
          },
        );
      }
    );
  }
}