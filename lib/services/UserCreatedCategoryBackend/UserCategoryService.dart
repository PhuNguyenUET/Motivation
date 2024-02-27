import 'package:motivation/models/quote_cate_linking.dart';
import 'package:motivation/models/user_category.dart';
import 'package:motivation/services/UserCreatedCategoryBackend/UserCategoryRepository.dart';

import '../../models/quote.dart';

class UserCategoryService {
  final _userCateRepo = UserCategoryRepository();

  Future<List<String>> getAllUserCategory() async {
    return await _userCateRepo.getAllUserCategory();
  }

  Future<List<Quote>> getQuotesByCate(String category) async {
    int cateId = await _userCateRepo.getIdFromCategory(category);
    if (cateId == -1) {
      return [];
    }
    return await _userCateRepo.getQuotesByCate(cateId);
  }

  Future<String> insertUserCategory(String category) async {
    int cateId = await _userCateRepo.getIdFromCategory(category);
    if (cateId != -1) {
      return 'This category already exists';
    }
    await _userCateRepo.insertUserCategory(UserCategory(category: category));
    return ("");
  }

  Future<String> deleteUserCategory(String category) async {
    int cateId = await _userCateRepo.getIdFromCategory(category);
    if (cateId == -1) {
      return "Unable to delete this category";
    }
    await _userCateRepo.deleteUserCategory(cateId);
    return "User category deleted";
  }

  Future<String> insertQuoteIntoCate(int quoteId, String category) async {
    int cateId = await _userCateRepo.getIdFromCategory(category);
    if (cateId == -1) {
      return "Unable to insert into this category";
    }
    await _userCateRepo.addQuoteToCategory(QuoteCateLinking(quoteId: quoteId, userCategoryId: cateId));
    return "Quote inserted successfully";
  }

  Future<String> deleteQuoteFromCate(int quoteId, String category) async {
    int cateId = await _userCateRepo.getIdFromCategory(category);
    if (cateId == -1) {
      return "Unable to delete from this category";
    }
    await _userCateRepo.deleteQuoteFromCate(QuoteCateLinking(quoteId: quoteId, userCategoryId: cateId));
    return "Quote deleted successfully";
  }

  Future<List<String>> getCategoriesInSearch(String input) async {
    return await _userCateRepo.getCategoriesInSearch(input);
  }
}