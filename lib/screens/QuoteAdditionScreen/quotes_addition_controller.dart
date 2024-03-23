import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:motivation/screens/Home/quote_integration.dart';

import '../../models/quote.dart';
import '../../models/userQuote.dart';

class QuotesAdditionController extends ChangeNotifier{
  final QuoteIntegration _backend = QuoteIntegration();

  Future<List<Quote>> getAllUserCreatedQuotes() async {
    return await _backend.getQuotes('user-created');
    //return [Quote(id: 0, quote: "Fuck you", author: "Fuck you"), Quote(id: 0, quote: "Fuck you", author: "Fuck you"), Quote(id: 0, quote: "Fuck you", author: "Fuck you"), Quote(id: 0, quote: "Fuck you", author: "Fuck you"), Quote(id: 0, quote: "Fuck you", author: "Fuck you")];
  }

  Future<String> insertQuote(UserQuote quote) async {
    String res = await _backend.insertQuote(quote);
    notifyListeners();
    return res;
  }

  Future<String> editQuote(Quote quote) async {
    return await _backend.updateQuote(quote);
  }

  Future<String> deleteQuote(Quote quote) async {
    return await _backend.deleteQuote(quote);
  }
}
