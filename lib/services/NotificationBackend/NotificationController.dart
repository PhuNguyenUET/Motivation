import 'package:motivation/services/NotificationBackend/NotificationService.dart';

import '../../models/notification_setting.dart';

class NotificationController {
  final _notificationService = NotificationService();

  Future<NotificationSetting> getNotificationSettings() async {
    return await _notificationService.getNotificationSettings();
  }

  Future<String> updateNotificationSettings(NotificationSetting notificationSetting) async {
    return await _notificationService.updateNotificationSettings(notificationSetting);
  }
}