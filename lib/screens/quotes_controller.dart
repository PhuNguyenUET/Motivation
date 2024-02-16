import 'package:flutter/cupertino.dart';
import 'package:motivation/main.dart';
import 'package:motivation/screens/quote_integration.dart';
import 'package:motivation/screens/quotes.dart';

import '../decor_controller.dart';
import '../models/quote.dart';

class QuoteController extends ChangeNotifier {
  Future<void> initInstance() async {
    if (_quoteList.isEmpty) {
      await _getNextQuotesBatch();
    }
  }
  static final _backend = QuoteIntegration();

  int _quoteIndex = 0;
  int get quoteIndex => _quoteIndex;

  Future<void> increaseQuoteIndex() async {
    _quoteIndex ++;
    if (_quoteIndex == _quoteList.length) {
      await _getNextQuotesBatch();
      _quoteIndex = 0;
    }
    notifyListeners();
  }

  void decreaseQuoteIndex() {
    if (_quoteIndex == 0) {
      return;
    }
    _quoteIndex --;
    notifyListeners();
  }

  String getCurrentQuote() {
    return _quoteList[_quoteIndex].quote;
  }

  String getCurrentAuthor() {
    return _quoteList[_quoteIndex].author == null ? ""
        : '- ${_quoteList[_quoteIndex].author} -';
  }

  List<Quote> _quoteList = [];
  String _category = 'general';

  String get category => _category;
  Future<void> setCategory(String cate) async {
    _category = cate;
    await _getNextQuotesBatch();
    notifyListeners();
  }

  Future<void> _getNextQuotesBatch() async {
    _quoteList = await _backend.get100Quotes(_category);
  }
}