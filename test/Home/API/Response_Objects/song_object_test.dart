import 'package:flutter_test/flutter_test.dart';

import '../../../../Lib/Home/API/Response_Objects/song_object.dart';

void main() {
  const String songName = "Wii Music";
  const String artist = "http://35.212.184.178/allusers/1/";
  const int start = 0;
  const int end = 15;
  const String song = "https://storage.googleapis.com/songsnippetbucket/mp3s/Wii_Sports.mp3?X-Goog-Algorithm=GOOG4-RSA-SHA256&X-Goog-Credential=422381896818-compute%40developer.gserviceaccount.com%2F20221129%2Fauto%2Fstorage%2Fgoog4_request&X-Goog-Date=20221129T063904Z&X-Goog-Expires=86400&X-Goog-SignedHeaders=host&X-Goog-Signature=49d73db9bc1849459bfda7f2203925720ec40c83128264d3cee90d93506f03172f77cd45ae0261280a776618de48480773132c3854ddcce61f32d7f7ac567b7c0c0e3be660b13f91093a7bb5e58df2d202fdfee44354cd289855f240803ca66f51a2768c4f90133088430cc26c0678fba208e3228754db99dfbfdf9bd74cb5eb669d275be1e653be99e84a2a3bc3b75c17596c08ab3c8bf294d9cd01c61b669d61f72cacc7fbf5d05306c2c9c1cc245e7259a4c84f6e8bb21231922cd3838bc2ec672d3b163a34fe952d1afdc1d3f65f2d222863ba7fe11b58c4ac9438b93cdd069d29befb69c16534976528414b5f2145961ee9c1e78309b7e14a0da8a471a2";

  const fakeSongListResponse = {
    "songName": songName,
    "artist": artist,
    "start": start,
    "end": end,
    "song": song
  };

  test('always true', () {
    expect(0, 0);
  });

  test('object generated', () {
    SongObject songObject = SongObject.fromJson(fakeSongListResponse);
    expect(songName, songObject.name);
    expect(artist, songObject.artist);
    expect(start, songObject.start);
    expect(end, songObject.end);
    expect(song, songObject.songUrl);
  });

}