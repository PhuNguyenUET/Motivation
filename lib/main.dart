import 'package:flutter/material.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:motivation/models/quote.dart';
import 'package:motivation/screens/CollectionScreen/QuoteInCollectionScreen.dart';
import 'package:motivation/screens/Notification/category_selection_screen.dart';
import 'package:motivation/screens/Notification/sound_selection_screen.dart';
import 'package:motivation/screens/QuoteAdditionScreen/add_quotes_screen.dart';
import 'package:motivation/screens/Font&Theme/all_background.dart';
import 'package:motivation/screens/Font&Theme/all_fonts.dart';
import 'package:motivation/screens/Home/home.dart';
import 'package:motivation/screens/UtilityScreens/loading_screen.dart';
import 'package:motivation/screens/Home/quotes_controller.dart';
import 'package:motivation/screens/Notification/reminder_screen_controller.dart';
import 'package:motivation/screens/Notification/reminders_screen.dart';
import 'package:motivation/screens/CollectionScreen/user_collection_screen.dart';
import 'package:motivation/screens/CollectionScreen/user_created_category_controller.dart';
import 'package:motivation/services/NotificationBackend/NotificationController.dart';
import 'package:motivation/services/post_notification_service.dart';
import 'package:provider/provider.dart';
import 'screens/Home/user_controller.dart';
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
        'assets/images/wallpaper_$i.jpg'
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
          ChangeNotifierProvider<UserCreatedCategoryController >(
            create: (_) => UserCreatedCategoryController(),
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
            '/collections': (context) => const UserCollectionScreen(),
            '/quoteInCate': (context) => const QuoteInCollectionScreen(),
            '/selectCateReminder': (context) => const CategorySelectionScreen(),
            '/selectSoundReminder': (context) => const SoundSelectionScreen(),
          },
        );
      }
    );
  }
}