import 'package:flutter/material.dart';
import 'package:motivation/screens/quote_integration.dart';
import 'package:motivation/screens/quotes.dart';

import 'models/quote.dart';

class DecorController extends ChangeNotifier {
  int _fontIndex = 0;
  int get fontIndex => _fontIndex;
  set fontIndex(int value) {
    _fontIndex = value;
    notifyListeners();
  }

  int _backgroundIndex = 0;
  int get backgroundIndex => _backgroundIndex;
  set backgroundIndex(int value) {
    _backgroundIndex = value;
    notifyListeners();
  }
}
