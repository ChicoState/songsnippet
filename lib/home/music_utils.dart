import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class MusicUtils {
  static const url =
      'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3'; // this is temporary
  late AudioPlayer _audioPlayer;

  MusicUtils() {
    _init();
  }

  //we moved the async task to the init method because we can't otherwise in the constructor
  void _init() async {
    _audioPlayer = AudioPlayer();
    await _audioPlayer.setUrl(
        url); //Seems like here is where we can change the song being played
  }

  void play() {
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
