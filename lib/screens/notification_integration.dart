import 'package:motivation/services/NotificationBackend/NotificationController.dart';

import '../models/notification_setting.dart';

class NotificationIntegration {
  final _backend = NotificationController();

  Future<NotificationSetting> getNotificationSettings() async {
    return await _backend.getNotificationSettings();
  }

  Future<String> updateNotificationSettings(NotificationSetting notificationSetting) async {
    return await _backend.updateNotificationSettings(notificationSetting);
  }
}