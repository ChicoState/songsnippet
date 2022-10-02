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
          future: songList,
          builder: (BuildContext context, AsyncSnapshot<SongList> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                print(snapshot.error);
                return Center(
                  child: Text("Something went wrong"),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data?.songList.length,
                  itemBuilder: (context, position) {
                    return createRow(context, position,
                        snapshot.data?.songList[position].name);
                  });
              }
            } else {
              return const Center(
                child: SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(),
                    ),
              );
            }
            // if (snapshot.connectionState == ConnectionState.done &&
            //     !snapshot.hasError && snapshot.hasData) {
            //     return   ListView.builder(
            //       itemCount: snapshot.data?.songList.length,
            //       itemBuilder: (context, position) {
            //         return createRow(context, position,
            //             snapshot.data?.songList[position].name);
            //       });
            // } else {
            //   return SizedBox(
            //     width: 60,
            //     height: 60,
            //     child: CircularProgressIndicator(),
            //   );
            // }
          },
        ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }



  Widget createRow(BuildContext context, int position, String? song) {
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
