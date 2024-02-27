import 'package:motivation/models/quote.dart';
import 'package:motivation/models/quote_cate_linking.dart';
import 'package:motivation/models/user_category.dart';
import 'package:sqflite/sqflite.dart';

import '../QuotesBackend/QuotesDatabase.dart';

class UserCategoryRepository {
  Future<List<String>> getAllUserCategory () async {
    final dbInstance = await QuotesDatabase.instance;
    final db = dbInstance.database;

    final List<Map<String, dynamic>> result = await db.rawQuery('SELECT category FROM user_categories;');

    return result.map((e) => e['category'] as String).toList();
  }

  Future<String> getCategoryById(int cateId) async {
    final dbInstance = await QuotesDatabase.instance;
    final db = dbInstance.database;

    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT * FROM user_categories WHERE id = $cateId;');

    return maps.map((e) => e['category'] as String).toList()[0];
  }

  Future<int> getIdFromCategory(String category) async {
    final dbInstance = await QuotesDatabase.instance;
    final db = dbInstance.database;

    final List<Map<String, dynamic>> result = await db.rawQuery("SELECT id FROM user_categories WHERE category = '$category'");

    return Sqflite.firstIntValue(result) ?? -1;
  }

  Future<List<Quote>> getQuotesByCate(int cateId) async {
    final dbInstance = await QuotesDatabase.instance;
    final db = dbInstance.database;

    final List<Map<String, dynamic>> result = await db.rawQuery('SELECT quotes.* FROM quotes JOIN linking ON quotes.id = linking.quoteId WHERE linking.userCategoryId = $cateId;');

    return result.map((e) => Quote.fromJson(e)).toList();
  }

  Future<void> insertUserCategory(UserCategory userCategory) async {
    final dbInstance = await QuotesDatabase.instance;
    final db = dbInstance.database;

    await db.insert(
      'user_categories',
      userCategory.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> addQuoteToCategory(QuoteCateLinking quoteCateLinking) async {
    final dbInstance = await QuotesDatabase.instance;
    final db = dbInstance.database;

    await db.insert(
      'linking',
      quoteCateLinking.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteUserCategory(int userCateId) async {
    final dbInstance = await QuotesDatabase.instance;
    final db = dbInstance.database;

    await db.delete(
      'user_categories',
      where: 'id = ?',
      whereArgs: [userCateId],
    );
  }

  Future<void> deleteQuoteFromCate(QuoteCateLinking quoteCateLinking) async {
    final dbInstance = await QuotesDatabase.instance;
    final db = dbInstance.database;

    await db.delete(
      'linking',
      where: 'quoteId = ? and userCategoryId = ?',
      whereArgs: [quoteCateLinking.quoteId, quoteCateLinking.userCategoryId],
    );
  }

  Future<List<String>> getCategoriesInSearch(String input) async {
    final dbInstance = await QuotesDatabase.instance;
    final db = dbInstance.database;

    final List<Map<String, dynamic>> result = await db.rawQuery("SELECT category FROM user_categories WHERE category LIKE '$input%'");

    return result.map((e) => e['category'] as String).toList();
  }
}