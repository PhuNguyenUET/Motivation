import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class SettingsTile extends StatelessWidget {
  final String name;
  final IconData icon;
  final Function? func;

  SettingsTile ( {required this.name, required this.icon, this.func} );

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 25.0,
        weight: 200,
        color: Colors.black,
      ),
      title: Text(
          name,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w300
        ),
      ),
      trailing: Icon(
        Symbols.arrow_right,
        size: 30.0,
        weight: 300,
        color: Colors.grey,
      ),
      tileColor: Colors.grey[200],
      onTap: null,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white, width: 0.5),
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
