class SongListResponse {
  final String songList;

  const SongListResponse({
    required this.songList;
})
  
  factory SongListResponse.fromJson(Map<String, dynamic> json) {
    return SongListResponse(songList: json["songList"])
  }
}