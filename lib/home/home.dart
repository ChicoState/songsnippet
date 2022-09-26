import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:song_snippet/resources/dimen.dart';
import 'package:song_snippet/resources/strings.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'music_utils.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final MusicUtils _musicUtils;

  @override
  void initState() {
    super.initState();
    _musicUtils = MusicUtils();
  }

  @override
  void dispose() {
    _musicUtils.dispose();
    super.dispose();
  }

  //test array, later on we will be getting this data from the backend
  final songNames = [
    "test",
    "test2",
    "test3",
    "test",
    "test2",
    "test3",
    "test",
    "test2",
    "test3"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(SongSnippetStrings.title),
      ),
      body: ListView.builder(
        itemCount: songNames.length,
        itemBuilder: (context, position) {
          return createRow(context, position, songNames[position]);
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget createRow(BuildContext context, int position, String song) {
    return GestureDetector(
        onTap: () {
          log('row $position');
        },
        child: Padding(
          padding: EdgeInsets.all(SongSnippetDimen.paddingHalf),
          child: Container(
            padding: const EdgeInsets.all(SongSnippetDimen.padding),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: TextButton(
              onPressed: _musicUtils.play,
              child: Text(song),
            ),
          ),
        ));
  }
}
