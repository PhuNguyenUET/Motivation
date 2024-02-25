import 'package:flutter/material.dart';
import 'package:motivation/models/notification_setting.dart';
import 'package:motivation/screens/reminder_screen_controller.dart';
import 'package:provider/provider.dart';

import 'loading_screen.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {

  NotificationSetting notificationSetting = NotificationSetting();

  @override
  Widget build(BuildContext context) {
    var reminderState = Provider.of<ReminderController>(context, listen: true);
    var loadingOverlay = LoadingScreen().loadingOverlay;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity! > 0) {
              Navigator.pop(context);
            }
          },
          child: FutureBuilder<void>(
              future: reminderState.initInstance(),
              builder: (BuildContext context,
                  AsyncSnapshot<void> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  Overlay.of(context).insert(loadingOverlay);
                } else {
                  loadingOverlay.remove();
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Text('Allow notifications?'),
                        //Switch(value: reminderState., onChanged: onChanged)
                      ],
                    )
                  ],
                );
              }
          )
      ),
    );
  }
}
