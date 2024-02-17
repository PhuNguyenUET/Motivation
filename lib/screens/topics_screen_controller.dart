import 'package:motivation/screens/quote_integration.dart';

class TopicsController {
  static final _backend = QuoteIntegration();

  Future<List<String>> getAllCategories() async {
    return await _backend.getAllCategories();
  }

  Future<List<String>> getCategoriesInSearch(String input) async {
    return await _backend.getCategoriesInSearch(input);
  }
}