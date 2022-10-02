import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:song_snippet/resources/dimen.dart';
import 'package:song_snippet/resources/strings.dart';

import 'API/Requests/getSongs.dart';
import 'API/ResponseObjects/songListObject.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  //test array, later on we will be getting this data from the backend
  late Future<SongList> songList;


  @override
  void initState() {
    super.initState();
    songList = getSongList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(SongSnippetStrings.title),
        ),
        body: FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if snap
          },
        ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  // ListView.builder(
  // itemCount: songList.length,
  // itemBuilder: (context, position) {
  // return createRow(context, position, songNames[position]);
  // },
  // ),
  FutureBuilder<SongList> SongListBuilder() {
    return
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
              color: Theme
                  .of(context)
                  .primaryColor,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Text(
              '$song',
            ),
          ),
        )
    );
  }


}
