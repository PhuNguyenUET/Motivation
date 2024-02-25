import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid = const AndroidInitializationSettings(
        'logo');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS
    );
    await notificationPlugin.initialize(initializationSettings,
    );
  }

    notificationDetails() {
      return NotificationDetails(
        android: AndroidNotificationDetails('ChannelId', 'ChannelName',
        importance: Importance.defaultImportance),
        iOS: DarwinNotificationDetails()
      );
    }

    Future<void> showNotification(
        {int id = 0, String? title, String? body, String? payLoad}) async {
    await notificationPlugin.zonedSchedule(0, 'Fuck this noti', "Fuck y'all <3", tz.TZDateTime.now(tz.local).add(Duration(seconds: 20)), notificationDetails(), androidScheduleMode: AndroidScheduleMode.inexact, uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
    print('Fuck it');
  }

}