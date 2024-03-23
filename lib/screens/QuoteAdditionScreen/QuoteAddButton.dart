import 'package:flutter/material.dart';
import 'package:motivation/screens/QuoteAdditionScreen/PopUpAddQuote.dart';
import 'package:motivation/screens/UtilityScreens/FakePopUpRoute.dart';
import 'package:popover/popover.dart';

import 'CustomRectTween.dart';

class FloatingQuoteAddButton extends StatelessWidget {
  FloatingQuoteAddButton({super.key, required this.insertFunction});

  VoidCallback insertFunction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(FakePopUpRoute(builder: (context) {
          return PopUpAddQuote(insertFunction: insertFunction,);
        }));
      },
      child: Hero(
        tag: 'quote-add-popup',
        createRectTween: (begin, end) {
          return CustomRectTween(begin: begin, end: end);
        },
        child: Material(
          color: Colors.lightBlueAccent,
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(
              Icons.add,
              size: 40,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
