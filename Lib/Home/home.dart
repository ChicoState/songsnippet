import 'dart:developer';
import 'package:flutter/material.dart';
import '../Utils/music_utils.dart';
import '../Resources/strings.dart';
import '../Resources/dimen.dart';
import 'home_view_model.dart';
import '../Home/API/Response_Objects/song_list_object.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final MusicUtils _musicUtils;
  late HomeViewModel homeViewModel;

  @override
  void initState() {
    super.initState();
    homeViewModel = HomeViewModel();
    _musicUtils = MusicUtils();
  }

  @override
  void dispose() {
    _musicUtils.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(SongSnippetStrings.title),
      ),
      body: FutureBuilder(
        future: homeViewModel.songList,
        builder: (BuildContext context, AsyncSnapshot<SongList> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Center( child: Text (SongSnippetStrings.error),);
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
                width: SongSnippetDimen.padding8x,
                height: SongSnippetDimen.padding8x,
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
