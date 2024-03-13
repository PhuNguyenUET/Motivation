import 'package:flutter/cupertino.dart';
import 'package:motivation/main.dart';
import 'package:motivation/screens/Home/quote_integration.dart';
import 'user_controller.dart';
import '../../models/quote.dart';

class QuoteController extends ChangeNotifier {
  int _quoteToInsert = 0;
  void setQuoteToInsert() {
    _quoteToInsert = _quoteIndex;
  }
  Future<void> initInstance(int startId) async {
    if (_quoteList.isEmpty || _quoteList[0].id == 0) {
      _quoteIndex = 0;
      await _getNextQuotesBatch();
    }
    if(startId != 0) {
      _quoteList[_quoteToInsert] = await _backend.getQuoteFromId(startId);
    }
  }
  static final _backend = QuoteIntegration();

  int _quoteIndex = 0;
  int get quoteIndex => _quoteIndex;

  bool _noQuotes = false;
  bool get noQuotes => _noQuotes;

  bool _isCategoryUserCreated = false;
  bool get isCategoryUserCreated => _isCategoryUserCreated;

  bool quoteNotAtStart() {
    return _quoteIndex != 0;
  }

  Future<void> increaseQuoteIndex() async {
    _quoteIndex ++;
    if (_quoteIndex == _quoteList.length) {
      if(_category == 'favourites' || _category == 'user-created') {
        _quoteIndex --;
        return;
      }
      if (!_isCategoryUserCreated) {
        await _getNextQuotesBatch();
      }
      _quoteIndex = 0;
    }
    notifyListeners();
  }

  void resetQuoteIndex() async {
    _quoteIndex = 0;
  }

   void setCategoryUserCreated(String category, List<Quote> quotes) {
     _quoteIndex = 0;
     _category = category;
     _isCategoryUserCreated = true;
     _quoteList = quotes;
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

  Quote getCurrentQuoteObject() {
    return _quoteList[_quoteIndex];
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
    _quoteIndex = 0;
    _category = cate;
    _isCategoryUserCreated = false;
    await _getNextQuotesBatch();
    notifyListeners();
  }

  Future<void> _getNextQuotesBatch() async {
    _quoteIndex = 0;
    _quoteList = await _backend.getQuotes(_category);
  }

  Future<void> forceRebuild() async {
    if (_category == 'user-created') {
      _quoteIndex = 0;
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