import 'song_object.dart';

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
