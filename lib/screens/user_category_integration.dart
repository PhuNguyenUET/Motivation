import 'package:motivation/services/UserCreatedCategoryBackend/UserCategoryController.dart';
import 'package:motivation/services/UserCreatedCategoryBackend/UserCategoryRepository.dart';

import '../models/quote.dart';

class UserCategoryIntegration {
  final UserCategoryController _backend = UserCategoryController();

  UserCategoryIntegration._internal();

  factory UserCategoryIntegration() {
    return _instance;
  }

  static final UserCategoryIntegration _instance = UserCategoryIntegration._internal();

  Future<List<String>> getAllUserCategory() async {
    return await _backend.getAllUserCategory();
  }

  Future<List<Quote>> getQuotesByCate(String category) async {
    return await _backend.getQuotesByCate(category);
  }

  Future<String> insertUserCategory(String category) async {
    return await _backend.insertUserCategory(category);
  }

  Future<String> deleteUserCategory(String category) async {
    return await _backend.deleteUserCategory(category);
  }

  Future<String> insertQuoteIntoCate(int quoteId, String category) async {
    return await _backend.insertQuoteIntoCate(quoteId, category);
  }

  Future<String> deleteQuoteFromCate(int quoteId, String category) async {
    return await _backend.deleteQuoteFromCate(quoteId, category);
  }

  Future<List<String>> getCategoriesInSearch(String input) async {
    return await _backend.getCategoriesInSearch(input);
  }
}