import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../models/quote.dart';

class QuoteTile extends StatelessWidget {
  Quote quote;
  void Function()? deleteFunction;
  QuoteTile({super.key,  required this.quote, required this.deleteFunction });

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
            IconButton(onPressed: deleteFunction, icon: Icon(Symbols.delete, color: Colors.redAccent,)),
          ],
        ),
      ),
    );
  }
}
