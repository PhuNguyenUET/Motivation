import 'package:flutter/material.dart';

class QuoteColumn extends StatelessWidget {
  String quote;
  String author;
  int fontId;
  QuoteColumn({super.key, required this.quote, required this.author, required this.fontId});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          quote,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'Font$fontId',
              color: Colors.white,
              fontSize: 25.0),
        ),
        Text(
          author,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'Font$fontId',
              color: Colors.white,
              fontSize: 15.0),
        )
      ],
    );
  }
}
