import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:motivation/models/notification_setting.dart';
import 'package:motivation/models/quote.dart';
import 'package:motivation/screens/Home/home.dart';
import 'package:motivation/services/NotificationBackend/NotificationController.dart';
import 'package:motivation/services/QuotesBackend/QuoteController.dart';
import 'package:motivation/utilities/time_parser.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  NotificationService._internal();

  factory NotificationService() {
    return instance;
  }

  static NotificationService? _instance;

  static NotificationService get instance {
    _instance ??= NotificationService._internal();
    return _instance!;
  }
  final FlutterLocalNotificationsPlugin notificationPlugin =
      FlutterLocalNotificationsPlugin();

  late final QuoteController quoteController;

  late final NotificationController notificationController;

  Future<int?> initNotification() async {
    quoteController = QuoteController();
    notificationController = NotificationController();
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@drawable/logo');

    var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onSelectNotification,
      onDidReceiveBackgroundNotificationResponse: _onSelectNotification
    );
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
    await notificationPlugin.getNotificationAppLaunchDetails();

    return notificationAppLaunchDetails!.notificationResponse?.id;
  }

  @pragma('vm:entry-point')
  static void _onSelectNotification(NotificationResponse notificationResponse) {
    Get.offAll(Home(startQuoteId : notificationResponse.id ?? 0));
  }

  notificationDetails(String soundInfo, String quote) {
    int rng = Random().nextInt(1e6.round());
    return NotificationDetails(
        android: AndroidNotificationDetails('NotificationChannelId$rng', 'NotificationChannelName',
            importance: Importance.max,
          priority: Priority.high,
          enableVibration: true,
          playSound: true,
          sound: RawResourceAndroidNotificationSound(soundInfo),
          styleInformation: BigTextStyleInformation(quote),
        ),
        iOS: DarwinNotificationDetails());
  }

  Future<void> calculateScheduleNotification() async {
    await notificationPlugin.cancelAll();
    print("Cancelled all");
    NotificationSetting notificationSetting = await notificationController.getNotificationSettings();
    if(notificationSetting.notiAllowed ?? false) {
      String category = notificationSetting.isGeneral! ? 'general' : await quoteController.getCategoryById(notificationSetting.categoryId!);
      String startTime = notificationSetting.startTime!;
      String endTime = notificationSetting.endTime!;
      int timeRepeated = notificationSetting.timeRepeated!;
      List<TimeOfDay> scheduledTime = _getTimesBetween(
          startTime, endTime, timeRepeated);
      for (int i = 1; i < scheduledTime.length; i++) {
        if(scheduledTime[i].hour != scheduledTime[i - 1].hour || scheduledTime[i].minute != scheduledTime[i - 1].minute) {
          int id = await quoteController.getRandomQuoteIdFromCate(category);
          await setUpNotification(id, scheduledTime[i].hour,
              scheduledTime[i].minute, "notification_sound_no_${notificationSetting.notiSoundId}");
        }
      }
    }
    print("Finished set up");
  }

  Future<void> setUpNotification(int id, int hour, int minute, String soundInfo) async {
    Quote quote = await quoteController.getQuoteFromId(id);
    String quoteBody = quote.quote;
    String authorBody = quote.author == null ? "" : "-${quote.author}-";
    String body = "$quoteBody \n $authorBody";
    await notificationPlugin.zonedSchedule(
        id,
        "New motivation arrived!",
        body,
        _nextInstanceOfSpecificTime(hour, minute),
        notificationDetails(soundInfo, body),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  tz.TZDateTime _nextInstanceOfSpecificTime(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  List<TimeOfDay> _getTimesBetween(String startTime, String endTime, int n) {
    final start = TimeUtility.parseTime(startTime);
    final end = TimeUtility.parseTime(endTime);

    final totalDuration = TimeUtility.minuteDifference(start, end);

    int interval = (totalDuration / (n)).ceil();
    int timesRepeated = (totalDuration / interval).round();
    final times = <TimeOfDay>[];
    var current = start;

    for (var i = 0; i < timesRepeated; i++) {
      times.add(current);
      current = TimeUtility.addMinutesToTime(current, interval);
    }

    return times;
  }
}
