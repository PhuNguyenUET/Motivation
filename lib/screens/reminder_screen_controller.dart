import 'dart:async';

import 'package:flutter/material.dart';
import 'package:motivation/models/notification_setting.dart';
import 'package:motivation/screens/notification_integration.dart';
import 'package:motivation/screens/quote_integration.dart';
import 'package:motivation/utilities/time_parser.dart';

class ReminderController extends ChangeNotifier {
  final NotificationIntegration _notificationIntegration = NotificationIntegration();
  final QuoteIntegration _quoteIntegration = QuoteIntegration();

  NotificationSetting? _notificationSetting;

  Future<String> initInstance() async {
    _notificationSetting ??= await _notificationIntegration.getNotificationSettings();
    return getCategory();
  }

  bool isNotificationAllowed() {
    return _notificationSetting!.notiAllowed!;
  }

  void changeNotificationAllowance() {
    _notificationSetting!.notiAllowed = !_notificationSetting!.notiAllowed!;
    notifyListeners();
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
    notifyListeners();
  }

  String getStartTime() {
    return _notificationSetting!.startTime!;
  }

  String getEndTime() {
    return _notificationSetting!.endTime!;
  }

  void add30MinToStartTime() {
    TimeOfDay startTime = TimeUtility.parseTime(_notificationSetting!.startTime!);

    startTime = TimeUtility.addMinutesToTime(startTime, 30);

    _notificationSetting!.startTime = TimeUtility.formatTimeOfDay(startTime);
    notifyListeners();
  }

  void remove30MinFromStartTime() {
    TimeOfDay startTime = TimeUtility.parseTime(_notificationSetting!.startTime!);

    startTime = TimeUtility.subtractMinutesFromTime(startTime, 30);

    _notificationSetting!.startTime = TimeUtility.formatTimeOfDay(startTime);
    notifyListeners();
  }

  void add30MinToEndTime() {
    TimeOfDay endTime = TimeUtility.parseTime(_notificationSetting!.endTime!);

    endTime = TimeUtility.addMinutesToTime(endTime, 30);

    _notificationSetting!.endTime = TimeUtility.formatTimeOfDay(endTime);
    notifyListeners();
  }

  void remove30MinFromEndTime() {
    TimeOfDay endTime = TimeUtility.parseTime(_notificationSetting!.endTime!);

    endTime = TimeUtility.subtractMinutesFromTime(endTime, 30);

    _notificationSetting!.endTime = TimeUtility.formatTimeOfDay(endTime);
    notifyListeners();
  }

  int getTimeRepeated() {
    return _notificationSetting!.timeRepeated!;
  }

  void increaseTimeRepeated() {
    _notificationSetting!.timeRepeated = _notificationSetting!.timeRepeated! + 1;
    notifyListeners();
  }

  void decreaseTimeRepeated() {
    _notificationSetting!.timeRepeated = _notificationSetting!.timeRepeated! -1;
    notifyListeners();
  }

  int getNotificationSound() {
    return _notificationSetting!.notiSoundId!;
  }

  void updateNotificationSound(int soundId) {
    _notificationSetting!.notiSoundId = soundId;
    notifyListeners();
  }

  Future<String> updateNotificationSettings() async {
    String result = await _notificationIntegration.updateNotificationSettings(_notificationSetting!);
    notifyListeners();
    return result;
  }
}