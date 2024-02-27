import 'package:motivation/services/NotificationBackend/NotificationController.dart';

import '../models/notification_setting.dart';

class NotificationIntegration {
  final NotificationController _backend = NotificationController();

  NotificationIntegration._internal();

  factory NotificationIntegration() {
    return _instance;
  }

  static final NotificationIntegration _instance = NotificationIntegration._internal();

  Future<NotificationSetting> getNotificationSettings() async {
    return await _backend.getNotificationSettings();
  }

  Future<String> updateNotificationSettings(NotificationSetting notificationSetting) async {
    return await _backend.updateNotificationSettings(notificationSetting);
  }
}