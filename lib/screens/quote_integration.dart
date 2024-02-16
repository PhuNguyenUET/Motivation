import 'package:motivation/services/QuotesBackend/QuoteController.dart';

import '../models/quote.dart';
import '../models/userQuote.dart';

class QuoteIntegration {
  final QuoteController _backend = QuoteController();

  QuoteIntegration._internal();

  factory QuoteIntegration() {
    return _instance;
  }

  static final QuoteIntegration _instance = QuoteIntegration._internal();

  Future<List<Quote>> get100Quotes(String cate) async {
    return await _backend.getQuotesByCate(cate);
  }

  Future<String> changeFavourite(Quote quote) async {
    return await _backend.changeFavourite(quote);
  }

  Future<String> deleteQuote(Quote quote) async {
    return await _backend.deleteQuote(quote);
  }

  Future<String> updateQuote(Quote quote) async {
    return await _backend.updateQuote(quote);
  }

  Future<String> insertQuote (UserQuote quote) async {
    return await _backend.insertQuote(quote);
  }
}