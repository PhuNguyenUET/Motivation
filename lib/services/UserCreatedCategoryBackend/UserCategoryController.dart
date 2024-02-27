import 'package:motivation/services/UserCreatedCategoryBackend/UserCategoryService.dart';

import '../../models/quote.dart';

class UserCategoryController {
  final _userCateService = UserCategoryService();

  Future<List<String>> getAllUserCategory() async {
    return await _userCateService.getAllUserCategory();
  }

  Future<List<Quote>> getQuotesByCate(String category) async {
    return await _userCateService.getQuotesByCate(category);
  }

  Future<String> insertUserCategory(String category) async {
    if(category.isEmpty) {
      return 'Category name cannot be left empty';
    }
    return await _userCateService.insertUserCategory(category);
  }

  Future<String> deleteUserCategory(String category) async {
    return await _userCateService.deleteUserCategory(category);
  }

  Future<String> insertQuoteIntoCate(int quoteId, String category) async {
    return await _userCateService.insertQuoteIntoCate(quoteId, category);
  }

  Future<String> deleteQuoteFromCate(int quoteId, String category) async {
    return await _userCateService.deleteQuoteFromCate(quoteId, category);
  }

  Future<List<String>> getCategoriesInSearch(String input) async {
    List<String> res = [];
    if (input.isEmpty) {
      List<String> backendAddition = await _userCateService.getAllUserCategory() ;
      res.addAll(backendAddition);
      return res;
    } else {
      List<String> backendAddition = await _userCateService.getCategoriesInSearch(input.toLowerCase());
      res.addAll(backendAddition);
      return res;
    }
  }
}