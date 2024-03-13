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

  Future<List<String>> getAllCategories() async {
    return await _quoteService.getAllCategories();
  }

  Future<int> getNumberOfFavourites() async {
    return await _quoteService.getNumberOfFavourites();
  }

  Future<List<String>> getCategoriesInSearch(String input) async {
    List<String> res = ['general'];
    if (input.isEmpty) {
      List<String> backendAddition = await _quoteService.getRandomCategories();
      res.addAll(backendAddition);
      return res;
    } else {
      List<String> backendAddition = await _quoteService.getCategoriesInSearch(input.toLowerCase());
      res.addAll(backendAddition);
      return res;
    }
  }

  Future<String> getCategoryById(int cateId) async {
    return await _quoteService.getCategoryById(cateId);
  }

  Future<int> getIdFromCategory(String category) async {
    return await _quoteService.getIdFromCategory(category);
  }

  Future<int> getNumberOfUserCreated() async {
    return await _quoteService.getNumberOfUserCreated();
  }

  Future<Quote> getQuoteFromId(int quoteId) async {
    return await _quoteService.getQuoteFromId(quoteId);
  }

  Future<int> getRandomQuoteIdFromCate(String category) async {
    return await _quoteService.getRandomQuoteIdByCate(category);
  }
}