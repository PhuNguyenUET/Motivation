import 'package:flutter/cupertino.dart';
import 'package:motivation/models/notification_setting.dart';
import 'package:motivation/screens/notification_integration.dart';
import 'package:motivation/screens/quote_integration.dart';

class ReminderController extends ChangeNotifier {
  final NotificationIntegration _notificationIntegration = NotificationIntegration();
  final QuoteIntegration _quoteIntegration = QuoteIntegration();

  NotificationSetting? _notificationSetting;

  Future<void> initInstance() async {
    _notificationSetting = await _notificationIntegration.getNotificationSettings();
  }

  bool isNotificationAllowed() {
    return _notificationSetting!.notiAllowed!;
  }

  void changeNotificationAllowance() {
    _notificationSetting!.notiAllowed = !_notificationSetting!.notiAllowed!;
  }

  Future<String> getCategory() async {
    if(_notificationSetting!.isGeneral!) {
      return 'general';
    }
    return await _quoteIntegration.getCategoryById(_notificationSetting!.categoryId!);
  }

  Future<void> setCategory(String category) async {
    if(category == 'general') {
      _notificationSetting!.isGeneral = true;
      return;
    }
    _notificationSetting!.isGeneral = false;
    _notificationSetting!.categoryId = await _quoteIntegration.getIdFromCategory(category);
  }



  Future<String> updateNotificationSettings() async {
    return await _notificationIntegration.updateNotificationSettings(_notificationSetting!);
  }
}