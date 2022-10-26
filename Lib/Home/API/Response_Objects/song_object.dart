class SongObject {
  static const keyName = "name";
  static const keyArtist = "artist";
  static const keyStart = "start";
  static const keyEnd = "end";
  static const keySongUrl = "song";

  final String name;
  final String artist;
  final int start;
  final int end;
  final String songUrl;

  const SongObject({
    required this.name,
    required this.artist,
    required this.start,
    required this.end,
    required this.songUrl
  });

  factory SongObject.fromJson(Map<String, dynamic> json) {
    return SongObject(name: json[keyName],
        artist: json[keyArtist],
        start: json[keyStart],
        end: json[keyEnd],
        songUrl: json[keySongUrl]);
  }
}