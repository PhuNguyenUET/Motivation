import 'package:motivation/models/quote.dart';
import 'package:motivation/screens/quote_integration.dart';
import 'package:motivation/services/QuotesBackend/QuoteController.dart';

class Quotes {
  late QuoteIntegration quoteIntegration;
  List<Quote> _quoteList = [];
  String _category = 'general';

  Quotes( {required this.quoteIntegration} );

  String get category => _category;
  set category(String category) {
    _category = category;
  }

  List<Quote> get quoteList => _quoteList;
  void getNextQuotesBatch() async {
    _quoteList = await quoteIntegration.get100Quotes(_category);
  }
}