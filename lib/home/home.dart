import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:song_snippet/resources/dimen.dart';
import 'package:song_snippet/resources/strings.dart';
import 'music_utils.dart';
import 'API/Requests/getSongs.dart';
import 'API/ResponseObjects/songListObject.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final MusicUtils _musicUtils;
  late Future<SongList> songList;


  @override
  void initState() {
    super.initState();
    songList = getSongList();
    _musicUtils = MusicUtils();
  }

  @override
  void dispose() {
    _musicUtils.dispose();
    super.dispose();
  }

  static const assetsPath = 'assets/audio/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(SongSnippetStrings.title),
      ),
      body: FutureBuilder(
        future: songList,
        builder: (BuildContext context, AsyncSnapshot<SongList> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Center( child: Text ("Something went wrong"),);
            } else {
              return ListView.builder(
                itemCount: snapshot.data?.songList.length,
                itemBuilder: (context, position) {
                  return createRow(context, position, snapshot.data?.songList[position]);
                });
            }
          } else {
            return const Center(
              child: SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              )
            );
          }
        },
      )
    );
  }

  Widget createRow(BuildContext context, int position, SongObject? song) {
    return GestureDetector(
      onTap: () {
        log('row $position');
      },
      child: Padding(
        padding: const EdgeInsets.all(SongSnippetDimen.paddingHalf),
        child: Container(
          padding: const EdgeInsets.all(SongSnippetDimen.padding),
          decoration: BoxDecoration(
            color: Theme
              .of(context)
              .primaryColor,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: TextButton(
            onPressed: () async {
              await _musicUtils.setUrl('${song?.songUrl}');
              _musicUtils.play(song!.start, song.end);
            },
            child: Text('${song?.name}'),
          ),
        ),
      ));
  }
}
