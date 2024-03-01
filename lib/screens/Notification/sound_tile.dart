import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class SoundTile extends StatefulWidget {
  int soundId;
  bool isSelected;
  void Function()? onPress;
  AudioPlayer player;
  SoundTile({super.key, required this.soundId, required this.isSelected, required this.onPress, required this.player});

  @override
  State<SoundTile> createState() => _SoundListState();
}

class _SoundListState extends State<SoundTile> {
  PlayerState? _playerState = PlayerState.stopped;

  StreamSubscription? _playerCompleteSubscription;
  StreamSubscription? _playerStateChangeSubscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initStreams();
  }

  @override
  void dispose() {
    _playerCompleteSubscription?.cancel();
    _playerStateChangeSubscription?.cancel();
    super.dispose();
  }

  Future<void> _play() async {
    if(_playerState == PlayerState.stopped) {
      await widget.player.stop();
      await widget.player.setSource(AssetSource('audio/Notification_sound_no_${widget.soundId}.wav'));
    }
    await widget.player.resume();
    setState(() => _playerState = PlayerState.playing);
  }

  Future<void> _pause() async {
    await widget.player.pause();
    setState(() => _playerState = PlayerState.paused);
  }

  void _initStreams() {
    _playerCompleteSubscription = widget.player.onPlayerComplete.listen((event) {
      setState(() {
        _playerState = PlayerState.stopped;
      });
    });

    _playerStateChangeSubscription =
        widget.player.onPlayerStateChanged.listen((state) {
          if (state == PlayerState.stopped) {
            setState(() {
              _playerState = state;
            });
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPress,
      child: Card(
        shape: widget.isSelected ? RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.blueAccent,
            )
        ) : RoundedRectangleBorder(),
        elevation: 1.0,
        child: ListTile(
          title: Text('Notification sound No.${widget.soundId}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(onPressed: widget.onPress, icon: widget.isSelected ? Icon(Icons.check_circle_outline,) : Icon(Icons.circle_outlined)),
            ],
          ),
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _playerState == PlayerState.playing ? IconButton(onPressed: _pause, icon: Icon(Icons.pause)) :
                  IconButton(onPressed: _play, icon: Icon(Icons.play_arrow))
            ],
          ),
        ),
      ),
    );
  }
}
