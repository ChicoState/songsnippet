import 'dart:convert';

import 'package:flutter/services.dart';

class SongList {
  static const keySongList = "songList";

  final List<SongObject> songList;

  const SongList({
    required this.songList
  });
  
  factory SongList.fromJson(List<dynamic> json) {
    List<SongObject> songListTemp = [];
    json.forEach((element) {
      songListTemp.add(SongObject.fromJson(element));
    });
    return SongList(songList: songListTemp);
  }
}


class SongObject {
  static const keyName = "name";
  static const keyArtist = "artist";
  static const keyStart = "start";
  static const keyEnd = "end";
  static const keySong = "song";

  final String name;
  final String artist;
  final int start;
  final int end;
  final String song;

  const SongObject({
    required this.name,
    required this.artist,
    required this.start,
    required this.end,
    required this.song
  });

  factory SongObject.fromJson(Map<String, dynamic> json) {
    return SongObject(name: json[keyName],
        artist: json[keyArtist],
        start: json[keyStart],
        end: json[keyEnd],
        song: json[keySong]);
  }
}