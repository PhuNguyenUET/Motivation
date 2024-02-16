import 'package:flutter/cupertino.dart';
import 'package:motivation/main.dart';
import 'package:motivation/screens/quote_integration.dart';
import 'package:motivation/screens/quotes.dart';

import '../decor_controller.dart';
import '../models/quote.dart';

class QuoteController extends ChangeNotifier {
  Future<List<Quote>> initInstance() async {
    if (quoteList.length < 10) {
      return await _getNextQuotesBatch();
    }
    return _quoteList;
  }
  static final _backend = QuoteIntegration();

  int _quoteIndex = 0;
  int get quoteIndex => _quoteIndex;

  Future<void> increaseQuoteIndex() async {
    _quoteIndex ++;
    if (_quoteIndex == _quoteList.length) {
      _quoteList = await _getNextQuotesBatch();
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
    return quoteList[_quoteIndex].quote;
  }

  String getCurrentAuthor() {
    return quoteList[_quoteIndex].author == null ? ""
        : '- ${quoteList[_quoteIndex].author} -';
  }

  List<Quote> _quoteList = [Quote(id: 0, quote: 'Fetch')];
  String _category = 'general';

  String get category => _category;
  set category(String category) {
    _category = category;
    notifyListeners();
  }

  List<Quote> get quoteList => _quoteList;
  set quoteList(List<Quote> q) {
    _quoteList = q;
    //notifyListeners();
  }
  Future<List<Quote>> _getNextQuotesBatch() async {
    return await _backend.get100Quotes(_category);
  }
}