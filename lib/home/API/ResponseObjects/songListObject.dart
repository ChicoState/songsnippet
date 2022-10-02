import 'dart:convert';

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
  static const keySong = "song";

  final String name;
  final String artist;
  final String song;

  const SongObject({
    required this.name,
    required this.artist,
    required this.song
  });

  factory SongObject.fromJson(Map<String, dynamic> json) {
    return SongObject(name: json[keyName], artist: json[keyArtist], song: json[keySong]);
  }
}