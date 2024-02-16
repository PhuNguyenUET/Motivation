import 'package:motivation/models/userQuote.dart';
import 'package:motivation/services/QuotesBackend/QuotesDatabase.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/quote.dart';

class QuoteRepository {
  Future<void> insertQuote(Quote quote) async {
    final dbInstance = await QuotesDatabase.instance;
    final db = dbInstance.database;

    await db.insert(
      'quotes',
      quote.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> getLines() async {
    final dbInstance = await QuotesDatabase.instance;
    final db = dbInstance.database;

    final result = await db.rawQuery("SELECT COUNT(*) FROM quotes;");

    return Sqflite.firstIntValue(result) ?? -1;
  }

  Future<List<Quote>> getRandom100Quotes() async {
    int lines = await getLines();
    print(lines);
    final dbInstance = await QuotesDatabase.instance;
    final db = dbInstance.database;

    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT * FROM quotes WHERE id IN (SELECT id FROM quotes ORDER BY RANDOM() LIMIT 100);');

    return maps.map((e) => Quote.fromJson(e)).toList();
  }

  Future<int> getCategoryId(String category) async {
    final dbInstance = await QuotesDatabase.instance;
    final db = dbInstance.database;

    final result = await db.rawQuery("SELECT id FROM categories WHERE category = '$category'");

    return Sqflite.firstIntValue(result) ?? -1;
  }

  Future<int> getQuoteCategoryId(Quote quote) async {
    final dbInstance = await QuotesDatabase.instance;
    final db = dbInstance.database;

    final result = await db.rawQuery("SELECT categoryId FROM quotes WHERE id = ${quote.id}");

    return Sqflite.firstIntValue(result) ?? -1;
  }

  Future<List<Quote>> getQuotesByCate(int cateId) async {
    final dbInstance = await QuotesDatabase.instance;
    final db = dbInstance.database;

    //TODO: Fix the query
    final result = await db.rawQuery('SELECT * FROM quotes WHERE id IN (SELECT id FROM quotes WHERE categoryId = $cateId ORDER BY RANDOM() LIMIT 100);');

    return result.map((e) => Quote.fromJson(e)).toList();
  }

  Future<void> updateQuote(Quote quote) async {
    final dbInstance = await QuotesDatabase.instance;
    final db = dbInstance.database;

    await db.update(
      'quotes',
      quote.toMap(),
      where: 'id = ?',
      whereArgs: [quote.id],
    );
  }

  Future<void> deleteQuote(Quote quote) async {
    final dbInstance = await QuotesDatabase.instance;
    final db = dbInstance.database;

    await db.delete(
      'quotes',
      where: 'id = ?',
      whereArgs: [quote.id],
    );
  }
}