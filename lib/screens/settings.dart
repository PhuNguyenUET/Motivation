import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:motivation/screens/settings_tile.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
              'Welcome, Sky',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          SizedBox(height: 7,),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                  'Settings',
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              SizedBox(height: 7),
              SettingsTile(name: 'General', icon: Symbols.settings),
              SettingsTile(name: 'App Icon', icon: Symbols.change_circle),
              SettingsTile(name: 'Reminder', icon: Symbols.notifications),
              SizedBox(height: 7),
              Text(
                'Personal',
                style: TextStyle(
                    fontSize: 20
                ),
              ),
              SizedBox(height: 7),
              SettingsTile(name: 'Collections', icon: Symbols.collections_bookmark),
              SettingsTile(name: 'Add your own', icon: Symbols.text_ad),
              SettingsTile(name: 'Your quotes', icon: Symbols.hourglass),
              SettingsTile(name: 'Favourites', icon: Symbols.favorite_border),
              SizedBox(height: 20),
            ],
          )
        ],
      ),
    );
  }
}
