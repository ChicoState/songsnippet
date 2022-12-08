class SongObject {
  static const keyName = "songName";
  static const keyArtist = "artist";
  static const keyStart = "start";
  static const keyEnd = "end";
  static const keySongUrl = "song";
  static const keyImageUrl = "image";
  static const keySongId = "id";

  final String name;
  final String artist;
  final int start;
  final int end;
  final String songUrl;
  final String imageUrl;
  final int songId;

  const SongObject({
    required this.name,
    required this.artist,
    required this.start,
    required this.end,
    required this.songUrl,
    required this.imageUrl,
    required this.songId,
  });

  factory SongObject.fromJson(Map<String, dynamic> json) {
    String? image = json[keyImageUrl];
    image ??= 'assets/images/gen_art.png';
    return SongObject(name: json[keyName],
        artist: json[keyArtist],
        start: json[keyStart],
        end: json[keyEnd],
        songUrl: json[keySongUrl],
        imageUrl: image,
        songId: json[keySongId]
    );
  }
}