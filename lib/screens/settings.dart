import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:motivation/screens/quotes_controller.dart';
import 'package:motivation/screens/settings_tile.dart';
import 'package:provider/provider.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    var quoteState = Provider.of<QuoteController>(context, listen: true);
    int numFav = 0;
    int numUserCreated = 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Welcome, Sky',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        SizedBox(
          height: 7,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Settings',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 7),
                SettingsTile(
                  name: 'General',
                  icon: Symbols.settings,
                  func: () {},
                ),
                SettingsTile(
                  name: 'App Icon',
                  icon: Symbols.change_circle,
                  func: () {},
                ),
                SettingsTile(
                  name: 'Reminder',
                  icon: Symbols.notifications,
                  func: () {},
                ),
                SizedBox(height: 7),
                Text(
                  'Personal',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 7),
                SettingsTile(
                  name: 'Collections',
                  icon: Symbols.collections_bookmark,
                  func: () {},
                ),
                SettingsTile(
                  name: 'Add your own',
                  icon: Symbols.text_ad,
                  func: () {},
                ),
                FutureBuilder<int>(
                    future: quoteState.getNumberOfUserCreated(),
                    builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                      if (snapshot.hasData) {
                        numUserCreated = snapshot.data ?? 0;
                      }
                      return SettingsTile(
                        name:
                        'Your quotes (${snapshot.connectionState == ConnectionState.done ? numUserCreated : 0})',
                        icon: Symbols.hourglass,
                        func: () async {
                          await quoteState.setCategory('user-created');
                          Navigator.pop(context);
                        },
                      );
                    }),
                FutureBuilder<int>(
                    future: quoteState.getNumberOfFavourites(),
                    builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                      if (snapshot.hasData) {
                        numFav = snapshot.data ?? 0;
                      }
                      return SettingsTile(
                        name:
                            'Favourites (${snapshot.connectionState == ConnectionState.done ? numFav : 0})',
                        icon: Symbols.favorite_border,
                        func: () async {
                          await quoteState.setCategory('favourites');
                          Navigator.pop(context);
                        },
                      );
                    }),
                SizedBox(height: 20),
              ],
            ),
          ),
        )
      ],
    );
  }
}
