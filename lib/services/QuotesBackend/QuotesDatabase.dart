import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:motivation/models/quote.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class QuotesDatabase {

  static late final Database? _database;

  QuotesDatabase._internal();

  factory QuotesDatabase() {
    return _instance!;
  }

  static QuotesDatabase? _instance;

  static Future<QuotesDatabase> get instance async {
    if (_instance == null) {
      _instance = QuotesDatabase._internal();
      _database = await _initDatabase();
    }
    return _instance!;
  }

  Database get database => _database!;

  static Future<Database> _initDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "quotes.db");

    // Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {
        print("Not existing");
      }

      // Copy from asset
      ByteData data = await rootBundle.load("assets/quotes.db");
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }

    // open the database
    return await openDatabase(path);
  }
}