class SongObject {
  static const keyID = "id";
  static const keyName = "songName";
  static const keyArtist = "artist";
  static const keyStart = "start";
  static const keyEnd = "end";
  static const keySongUrl = "song";

  final String id;
  final String name;
  final String artist;
  final int start;
  final int end;
  final String songUrl;

  const SongObject({
    required this.id,
    required this.name,
    required this.artist,
    required this.start,
    required this.end,
    required this.songUrl
  });

  factory SongObject.fromJson(Map<String, dynamic> json) {
    return SongObject(name: json[keyName],
        id: json[keyID],
        artist: json[keyArtist],
        start: json[keyStart],
        end: json[keyEnd],
        songUrl: json[keySongUrl]);
  }
}