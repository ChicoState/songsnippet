import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class MusicUtils {
  late AudioPlayer _audioPlayer;

  MusicUtils() {
    _init();
  }
  
  //we moved the async task to the init method because we can't otherwise in the constructor
  void _init() async {
    _audioPlayer = AudioPlayer();
  }

  Future<Duration?> setAsset(String asset) async {
    return _audioPlayer.setAsset(asset);
  }

  Future<Duration?> setUrl(String url) async {
    return _audioPlayer.setUrl(url);
  }

  void play(int startTime, int endTime) async {
    await _audioPlayer.setClip(start: Duration(seconds: startTime), end: Duration(seconds:endTime));
    _audioPlayer.play();
  }

  void pause() {
    _audioPlayer.pause();
  }

  void dispose() {
    _audioPlayer.dispose();
  }

  final progressNotifier = ValueNotifier<ProgressBarState>(
    ProgressBarState(
      current: Duration.zero,
      buffered: Duration.zero,
      total: Duration.zero,
    ),
  );
  final buttonNotifier = ValueNotifier<ButtonState>(ButtonState.paused);
}

class ProgressBarState {
  ProgressBarState({
    required this.current,
    required this.buffered,
    required this.total,
  });
  final Duration current;
  final Duration buffered;
  final Duration total;
}

enum ButtonState { paused, playing, loading }
