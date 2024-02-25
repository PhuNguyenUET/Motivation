import 'package:motivation/models/notification_setting.dart';
import 'package:motivation/services/QuotesBackend/QuotesDatabase.dart';
import 'package:sqflite/sqflite.dart';

class NotificationRepository {
  Future<NotificationSetting> getNotificationSettings () async {
    final dbInstance = await QuotesDatabase.instance;
    final db = dbInstance.database;

    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT * FROM notifications WHERE id = 1;');

    return maps.map((e) => NotificationSetting.fromJson(e)).toList()[0];
  }

  Future<void> updateNotificationSettings(NotificationSetting notificationSetting) async {
    final dbInstance = await QuotesDatabase.instance;
    final db = dbInstance.database;

    await db.update(
        'notifications',
        notificationSetting.toMap(),
        where: 'id = ?',
        whereArgs: [notificationSetting.id],
        conflictAlgorithm: ConflictAlgorithm.replace
    );
  }
}