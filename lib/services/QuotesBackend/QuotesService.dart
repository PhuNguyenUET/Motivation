import 'package:motivation/constants/constants.dart';
import 'package:motivation/models/quote.dart';
import 'package:motivation/models/userQuote.dart';
import 'package:motivation/services/QuotesBackend/QuotesRepository.dart';

class QuotesService {
  final _quotesRepository = QuoteRepository();

  Future<String> insertQuote(UserQuote quote) async {
    await _quotesRepository.insertQuote(Quote.fromUserQuote(quote));
    return "Quotes inserted successfully";
  }

  Future<String> deleteUserQuote(Quote quote) async {
    int cateId = await _quotesRepository.getQuoteCategoryId(quote);
    if (cateId == -1) {
      return "Error updating: category cannot be found";
    }
    if (cateId != Constants.CATE_USER_CREATED) {
      return "You cannot delete this quote!";
    }
    await _quotesRepository.deleteQuote(quote);
    return "Quotes deleted successfully";
  }

  Future<String> updateUserQuote(Quote quote) async {
    int cateId = await _quotesRepository.getQuoteCategoryId(quote);
    if (cateId == -1) {
      return "Error updating: category cannot be found";
    }
    if (cateId != Constants.CATE_USER_CREATED) {
      return "You cannot update this quote!";
    }
    await _quotesRepository.updateQuote(quote);
    return "Quotes updated successfully";
  }

  Future<String> changeFavourite(Quote quote) async {
    await _quotesRepository.updateQuote(quote);
    if (quote.favourite!) {
      return "You liked this quote";
    } else {
      return "You unliked this quote";
    }
  }

  Future<List<Quote>> getQuoteByCategory(String cate) async {
    if (cate == 'general') {
      var res = await _quotesRepository.getRandom100Quotes();
      print (res.length);
      return res;
    } else {
      int cateId = await _quotesRepository.getCategoryId(cate);
      if (cateId == -1) {
        return [];
      } else {
        return await _quotesRepository.getQuotesByCate(cateId);
      }
    }
  }
}