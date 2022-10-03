import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:song_snippet/resources/dimen.dart';
import 'package:song_snippet/resources/strings.dart';
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

  final songNames = [
    "I Really Want to Stay at Your House",
    "Yi Jian Mei",
  ];

  final artistNames = [
    "Rosa Walton & Hallie Coggins",
    "Yu-Ching Fei",
  ];

  final clipTime = [
    220,
    91,
  ];

  static const assetsPath = 'assets/audio/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(SongSnippetStrings.title),
      ),
      body: ListView.builder(
        itemCount: songNames.length,
        itemBuilder: (context, position) {
          return createRow(context, position, songNames[position], artistNames[position], clipTime[position]);
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget createRow(BuildContext context, int position, String song, String artist, int start) {
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
              onPressed: () async {
                await _musicUtils.setAsset('$assetsPath$artist - $song.mp3');
                _musicUtils.play(start, start+10);
              },
              child: Text(song),
            ),
          ),
        ));
  }
}
