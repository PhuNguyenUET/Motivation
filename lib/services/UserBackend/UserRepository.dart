import 'package:motivation/services/UserBackend/UserDatabase.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/user.dart';

class UserRepository {
  Future<User> getUser () async {
    final dbInstance = await UserDatabase.instance;
    final db = dbInstance.database;

    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT * FROM user_data WHERE id = 1;');

    return maps.map((e) => User.fromJson(e)).toList()[0];
  }

  Future<void> updateUser(User user) async {
    final dbInstance = await UserDatabase.instance;
    final db = dbInstance.database;

    print('Updated here');

    await db.update(
        'user_data',
        user.toMap(),
        where: 'id = ?',
        whereArgs: [user.id],
        conflictAlgorithm: ConflictAlgorithm.replace
    );
  }
}