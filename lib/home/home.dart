import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:song_snippet/resources/dimen.dart';
import 'package:song_snippet/resources/strings.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  //test array, later on we will be getting this data from the backend
  final songNames = ["test", "test2", "test3","test",
                "test2", "test3","test", "test2", "test3"];


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
          decoration: BoxDecoration (
            color: Theme.of(context).primaryColor,
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
