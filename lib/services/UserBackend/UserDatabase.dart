import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:motivation/models/quote.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/user.dart';

class UserDatabase {
  static late final Database? _database;

  UserDatabase._internal();

  factory UserDatabase() {
    return _instance!;
  }

  static UserDatabase? _instance;

  static Future<UserDatabase> get instance async {
    if (_instance == null) {
      _instance = UserDatabase._internal();
      _database = await _initDatabase();
    }
    return _instance!;
  }

  Database get database => _database!;

  static Future<Database> _initDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "user.db");

    var exists = await databaseExists(path);

    // open the database
    var database = await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE IF NOT EXISTS user_data (\n"
              "	id integer PRIMARY KEY AUTOINCREMENT,\n"
              " name text default 'Sky',\n"
              " background_id integer default 0,\n"
              " font_id integer default 0\n"
              ");",
        );
      },
      version: 1,
    );
    if(!exists) {await database.insert('user_data', User(name: 'Sky', backgroundId: 0, fontId: 0).toMap(), conflictAlgorithm: ConflictAlgorithm.replace);}
    return database;
  }
}
