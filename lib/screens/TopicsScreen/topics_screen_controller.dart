import 'package:motivation/screens/Home/quote_integration.dart';

class TopicsController {
  static final _backend = QuoteIntegration();

  Future<List<String>> getAllCategories() async {
    return await _backend.getAllCategories();
  }

  Future<List<String>> getCategoriesInSearch(String input) async {
    return await _backend.getCategoriesInSearch(input);
  }
}