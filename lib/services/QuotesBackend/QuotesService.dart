import 'package:motivation/constants/constants.dart';
import 'package:motivation/models/quote.dart';
import 'package:motivation/models/userQuote.dart';
import 'package:motivation/services/QuotesBackend/QuotesRepository.dart';

class QuotesService {
  final _quotesRepository = QuoteRepository();

  Future<String> insertQuote(UserQuote quote) async {
    int cateId = await _quotesRepository.getCategoryId('user-created');
    await _quotesRepository.insertQuote(Quote.fromUserQuote(quote, cateId));
    return "Quotes inserted successfully";
  }

  Future<String> deleteUserQuote(Quote quote) async {
    int cateId = await _quotesRepository.getQuoteCategoryId(quote);
    int userCateId = await _quotesRepository.getCategoryId('user-created');
    if (cateId == -1) {
      return "Error updating: category cannot be found";
    }
    if (cateId != userCateId) {
      return "You cannot delete this quote!";
    }
    await _quotesRepository.deleteQuote(quote);
    return "Quotes deleted successfully";
  }

  Future<String> updateUserQuote(Quote quote) async {
    int cateId = await _quotesRepository.getQuoteCategoryId(quote);
    int userCateId = await _quotesRepository.getCategoryId('user-created');
    if (cateId == -1) {
      return "Error updating: category cannot be found";
    }
    if (cateId != userCateId) {
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
      return res;
    } else if (cate == 'favourites') {
      var res = await _quotesRepository.getAllFavouriteQuotes();
      return res;
    } else if (cate == 'user-created') {
      int cateId = await _quotesRepository.getCategoryId(cate);
      var res = await _quotesRepository.getAllQuotesFromCategory(cateId);
      return res;
    }else {
      int cateId = await _quotesRepository.getCategoryId(cate);
      if (cateId == -1) {
        return [];
      } else {
        return await _quotesRepository.getQuotesByCate(cateId);
      }
    }
  }

  Future<String> getCategoryById(int cateId) async {
    if(cateId == 0) {
      return 'general';
    }
    return await _quotesRepository.getCategoryById(cateId);
  }

  Future<int> getIdFromCategory(String category) async {
    if(category == 'general') {
      return 0;
    }
    return await _quotesRepository.getCategoryId(category);
  }

  Future<List<String>> getAllCategories() async {
    return await _quotesRepository.getCategoryList();
  }

  Future<List<String>> getRandomCategories() async {
    return await _quotesRepository.getRandomCategory();
  }

  Future<int> getNumberOfFavourites() async {
    return await _quotesRepository.getNumberOfFavourite();
  }

  Future<List<String>> getCategoriesInSearch(String input) async {
    return await _quotesRepository.getCategoriesInSearch(input);
  }

  Future<int> getNumberOfUserCreated() async {
    int cateId = await _quotesRepository.getCategoryId('user-created');
    return await _quotesRepository.getNumberOfQuotesInCategory(cateId);
  }
}