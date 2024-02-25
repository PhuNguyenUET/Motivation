import 'package:flutter/cupertino.dart';
import 'package:motivation/main.dart';
import 'package:motivation/screens/quote_integration.dart';
import 'user_controller.dart';
import '../models/quote.dart';

class QuoteController extends ChangeNotifier {
  Future<void> initInstance() async {
    if (_quoteList.length <= 1) {
      await _getNextQuotesBatch();
    }
  }
  static final _backend = QuoteIntegration();

  int _quoteIndex = 0;
  int get quoteIndex => _quoteIndex;

  bool _noQuotes = false;
  bool get noQuotes => _noQuotes;

  Future<void> increaseQuoteIndex() async {
    _quoteIndex ++;
    if (_quoteIndex == _quoteList.length) {
      if(_category == 'favourites') {
        _quoteIndex --;
        return;
      }
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
    if (_quoteList.isEmpty) {
      _noQuotes = true;
      return "No quotes found in this category";
    }
    _noQuotes = false;
    return _quoteList[_quoteIndex].quote;
  }

  Future<void> changeFavouriteCurrentQuote() async {
    Quote currentQuote = _quoteList[_quoteIndex];
    currentQuote.favourite = !currentQuote.favourite!;
    await _backend.changeFavourite(currentQuote);
    //notifyListeners();
  }

  bool isCurrentQuoteFav() {
    if (_quoteList.isEmpty) {
      return false;
    }
    return _quoteList[_quoteIndex].favourite ?? false;
  }

  String getCurrentAuthor() {
    if(_quoteList.isEmpty) {
      return "";
    }
    return _quoteList[_quoteIndex].author == null ? ""
        : '- ${_quoteList[_quoteIndex].author} -';
  }

  List<Quote> _quoteList = [Quote(id: 0, quote: 'Fetching...')];
  String _category = 'general';

  String get category => _category;
  Future<void> setCategory(String cate) async {
    _category = cate;
    await _getNextQuotesBatch();
    notifyListeners();
  }

  Future<void> _getNextQuotesBatch() async {
    _quoteList = await _backend.getQuotes(_category);
  }

  Future<void> forceRebuild() async {
    if (_category == 'user-created') {
      await _getNextQuotesBatch();
      notifyListeners();
    }
  }

  Future<int> getNumberOfFavourites() async {
    return await _backend.getNumberOfFavourites();
  }

  Future<int> getNumberOfUserCreated() async {
    return await _backend.getNumberOfUserCreated();
  }
}