import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:motivation/screens/Notification/category_tile.dart';
import 'package:motivation/screens/Notification/reminder_screen_controller.dart';
import 'package:motivation/screens/Notification/sound_tile.dart';
import 'package:motivation/screens/UtilityScreens/loading.dart';
import 'package:provider/provider.dart';

class SoundSelectionScreen extends StatefulWidget {
  const SoundSelectionScreen({super.key});

  @override
  State<SoundSelectionScreen> createState() =>
      _SoundSelectionScreenState();
}

class _SoundSelectionScreenState extends State<SoundSelectionScreen> {
  int? currentSound;
  final player = AudioPlayer();

  final _streamController = StreamController<int>.broadcast();

  Stream<int> get soundStream => _streamController.stream;

  Future<void> destroyPlayer() async {
    await player.stop();
    await player.dispose();
  }

  @override
  Future<void> dispose() async {
    // TODO: implement dispose
    Future.delayed(Duration.zero, () async {
      await destroyPlayer();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var reminderState = Provider.of<ReminderController>(context, listen: true);

    Future<void> initInstance() async {
      currentSound ??= reminderState.getNotificationSound();
    }

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
                future: initInstance(),
                builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                  if(snapshot.hasError) {
                    print(snapshot.error);
                  }
                  return Column(
                    children: [
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Select notification sound',
                        style: TextStyle(fontSize: 17),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Expanded(
                        child: snapshot.connectionState == ConnectionState.done
                            ? AnimationLimiter(
                          child: ListView.builder(
                            cacheExtent: 1000,
                              itemCount: 12,
                              scrollDirection: Axis.vertical,
                              itemBuilder:
                                  (BuildContext context, int index) {
                                return AnimationConfiguration
                                    .staggeredList(
                                  position: index,
                                  duration:
                                  const Duration(milliseconds: 700),
                                  child: SlideAnimation(
                                    verticalOffset: 500.0,
                                    child: FadeInAnimation(
                                      child: Padding(
                                          padding:
                                          const EdgeInsets.symmetric(
                                              vertical: 3.0,
                                              horizontal: 4.0),
                                          child: SoundTile(
                                            soundId: index,
                                            soundStream: soundStream,
                                            currentSelectedId: currentSound,
                                            onPress: () {
                                              currentSound = index;
                                              _streamController.add(currentSound!);
                                            },
                                            player: player,
                                          )),
                                    ),
                                  ),
                                );
                              }),
                        )
                            : Loading(),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          reminderState.setNotificationSound(currentSound!);
                          Navigator.pop(context);
                        },
                        child: Text("Save"),
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
                        ),
                      ),
                      SizedBox(height: 10,),
                    ],
                  );
                })));
  }
}
