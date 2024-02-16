import 'package:motivation/screens/quote_integration.dart';

class TopicsController {
  static final _backend = QuoteIntegration();

  Future<List<String>> getAllCategories() async {
    return await _backend.getAllCategories();
  }

  Future<List<String>> getRandomCategories() async {
    List<String> res = ['general'];
    List<String> backendAddition = await _backend.getRandomCategories();
    res.addAll(backendAddition);
    return res;
  }
}