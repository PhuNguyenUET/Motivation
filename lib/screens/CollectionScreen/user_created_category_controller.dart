import 'package:flutter/cupertino.dart';
import 'package:motivation/screens/CollectionScreen/user_category_integration.dart';

import '../../models/quote.dart';

class UserCreatedCategoryController extends ChangeNotifier {
  static final _backend = UserCategoryIntegration();

  String currentCategory = '';

  Future<List<String>> getCategories(String search) async {
    return await _backend.getCategoriesInSearch(search);
  }

  Future<List<Quote>> getQuotesByCate() async {
    return await _backend.getQuotesByCate(currentCategory);
  }

  Future<String> insertUserCategory(String category) async {
    String res = await _backend.insertUserCategory(category);
    if (res.isEmpty) {
      notifyListeners();
    }
    return res;
  }

  Future<String> deleteUserCategory(String category) async {
    String res = await _backend.deleteUserCategory(category);
    notifyListeners();
    return res;
  }

  Future<String> insertQuoteIntoCate(int quoteId, String category) async {
    String res = await _backend.insertQuoteIntoCate(quoteId, category);
    notifyListeners();
    return res;
  }

  Future<String> deleteQuoteFromCate(int quoteId) async {
    String res = await _backend.deleteQuoteFromCate(quoteId, currentCategory);
    notifyListeners();
    return res;
  }
}