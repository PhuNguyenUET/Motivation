import 'package:motivation/services/NotificationBackend/NotificationRepository.dart';

import '../../models/notification_setting.dart';

class NotificationService {
  final _notificationRepository = NotificationRepository();

  Future<NotificationSetting> getNotificationSettings() async {
    return await _notificationRepository.getNotificationSettings();
  }

  Future<String> updateNotificationSettings(NotificationSetting newNotificationSetting) async {
    NotificationSetting oldNotificationSettings = await getNotificationSettings();
    if (oldNotificationSettings == newNotificationSetting) {
      return "No change detected";
    } else if (oldNotificationSettings.id != newNotificationSetting.id) {
      return "Cannot create new object of this type";
    }
    await _notificationRepository.updateNotificationSettings(newNotificationSetting);
    return "Notification settings updated successfully!";
  }
}