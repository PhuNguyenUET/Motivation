import 'dart:async';

import 'package:motivation/models/userQuote.dart';
import 'package:motivation/services/QuotesBackend/QuotesService.dart';

import '../../models/quote.dart';

class QuoteController {
  final _quoteService = QuotesService();

  Future<String> insertQuote (UserQuote quote) async {
    if(quote.quote.isEmpty) {
      return "You cannot insert an empty quote";
    }
    return await _quoteService.insertQuote(quote);
  }

  Future<String> deleteQuote(Quote quote) async {
    return await _quoteService.deleteUserQuote(quote);
  }

  Future<String> updateQuote(Quote quote) async {
    if(quote.quote.isEmpty) {
      return "You cannot update quote to be empty";
    }
    return await _quoteService.updateUserQuote(quote);
  }

  Future<String> changeFavourite(Quote quote) async {
    return await _quoteService.changeFavourite(quote);
  }

  Future<List<Quote>> getQuotesByCate(String cate) async {
    return await _quoteService.getQuoteByCategory(cate);
  }
}