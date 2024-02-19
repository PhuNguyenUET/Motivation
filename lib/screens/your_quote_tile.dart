import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../models/quote.dart';

class YourQuoteTile extends StatelessWidget {
  Quote quote;
  void Function()? editFunction;
  void Function()? deleteFunction;
  YourQuoteTile({super.key,  required this.quote, required this.editFunction, required this.deleteFunction });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0,
      child: ListTile(
        title: Text(quote.quote),
        subtitle: Text(quote.author ?? ""),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(onPressed: editFunction, icon: Icon(Symbols.edit)),
            IconButton(onPressed: deleteFunction, icon: Icon(Symbols.delete)),
          ],
        ),
      ),
    );
  }
}
