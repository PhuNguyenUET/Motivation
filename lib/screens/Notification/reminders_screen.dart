import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:motivation/models/notification_setting.dart';
import 'package:motivation/screens/Notification/reminder_screen_controller.dart';
import 'package:provider/provider.dart';

import '../UtilityScreens/loading_screen.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  bool isNotiAllowed = false;
  int timeRepeated = 10;
  String category = 'general';
  String startTime = '08:30';
  String endTime = '22:00';
  int notiSoundId = 0;


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
          child: FutureBuilder<String>(
              future: reminderState.initInstance(),
              builder: (BuildContext context,
                  AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  //Overlay.of(context).insert(loadingOverlay);
                } else {
                  //loadingOverlay.remove();
                  isNotiAllowed = reminderState.isNotificationAllowed();
                  category = snapshot.data ?? 'general';
                  startTime = reminderState.getStartTime();
                  endTime = reminderState.getEndTime();
                  notiSoundId = reminderState.getNotificationSound();
                  timeRepeated = reminderState.getTimeRepeated();
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Allow notifications?'),
                        SizedBox(width: 20,),
                        Switch(value: isNotiAllowed,
                          activeColor: Colors.blueAccent,
                          onChanged: (bool value) {
                            reminderState.changeNotificationAllowance();
                          },
                        )
                      ],
                    ),
                    SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Category'),
                          Expanded(child: Container()),
                          Text('$category'),
                          IconButton(onPressed: () {
                            Navigator.pushNamed(context, '/selectCateReminder');
                          }, icon: Icon(Icons.arrow_forward_ios, size: 15,)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Time repeated'),
                          Expanded(child: Container()),
                          IconButton(onPressed: () {reminderState.decreaseTimeRepeated();}, icon: Icon(Icons.arrow_back_ios, size: 15,)),
                          Text('${timeRepeated}x'),
                          IconButton(onPressed: () {reminderState.increaseTimeRepeated();}, icon: Icon(Icons.arrow_forward_ios, size: 15,)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Start time:'),
                          Expanded(child: Container()),
                          IconButton(onPressed: () {reminderState.remove30MinFromStartTime();}, icon: Icon(Icons.arrow_back_ios, size: 15,)),
                          Text('$startTime'),
                          IconButton(onPressed: () {reminderState.add30MinToStartTime();}, icon: Icon(Icons.arrow_forward_ios, size: 15,)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('End time:'),
                          Expanded(child: Container()),
                          IconButton(onPressed: () {reminderState.remove30MinFromEndTime();}, icon: Icon(Icons.arrow_back_ios, size: 15,)),
                          Text('$endTime'),
                          IconButton(onPressed: () {reminderState.add30MinToEndTime();}, icon: Icon(Icons.arrow_forward_ios, size: 15,)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Notification Sound'),
                          Expanded(child: Container()),
                          Text('$notiSoundId'),
                          IconButton(onPressed: () {
                            Navigator.pushNamed(context, '/selectSoundReminder');
                          }, icon: Icon(Icons.arrow_forward_ios, size: 15,)),
                        ],
                      ),
                    ),
                    SizedBox(height: 15,),
                    ElevatedButton(
                        onPressed: () async { await reminderState.updateNotificationSettings();},
                        child: Text("Save"),
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
                      ),
                    )
                  ],
                );
              }
          )
      ),
    );
  }
}
