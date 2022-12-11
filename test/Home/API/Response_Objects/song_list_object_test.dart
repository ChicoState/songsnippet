import 'package:flutter_test/flutter_test.dart';

import '../../../../Lib/Home/API/Response_Objects/song_list_object.dart';

void main() {
  const String songName1 = "Wii Music";
  const String artist1 = "http://35.212.184.178/allusers/1/";
  const int start1 = 0;
  const int end1 = 15;
  const String song1 = "https://storage.googleapis.com/songsnippetbucket/mp3s/Wii_Sports.mp3?X-Goog-Algorithm=GOOG4-RSA-SHA256&X-Goog-Credential=422381896818-compute%40developer.gserviceaccount.com%2F20221129%2Fauto%2Fstorage%2Fgoog4_request&X-Goog-Date=20221129T063904Z&X-Goog-Expires=86400&X-Goog-SignedHeaders=host&X-Goog-Signature=49d73db9bc1849459bfda7f2203925720ec40c83128264d3cee90d93506f03172f77cd45ae0261280a776618de48480773132c3854ddcce61f32d7f7ac567b7c0c0e3be660b13f91093a7bb5e58df2d202fdfee44354cd289855f240803ca66f51a2768c4f90133088430cc26c0678fba208e3228754db99dfbfdf9bd74cb5eb669d275be1e653be99e84a2a3bc3b75c17596c08ab3c8bf294d9cd01c61b669d61f72cacc7fbf5d05306c2c9c1cc245e7259a4c84f6e8bb21231922cd3838bc2ec672d3b163a34fe952d1afdc1d3f65f2d222863ba7fe11b58c4ac9438b93cdd069d29befb69c16534976528414b5f2145961ee9c1e78309b7e14a0da8a471a2";
  const String songName2 = "2Wii Music";
  const String artist2 = "2http://35.212.184.178/allusers/1/";
  const int start2 = 20;
  const int end2 = 215;
  const String song2 = "2https://storage.googleapis.com/songsnippetbucket/mp3s/Wii_Sports.mp3?X-Goog-Algorithm=GOOG4-RSA-SHA256&X-Goog-Credential=422381896818-compute%40developer.gserviceaccount.com%2F20221129%2Fauto%2Fstorage%2Fgoog4_request&X-Goog-Date=20221129T063904Z&X-Goog-Expires=86400&X-Goog-SignedHeaders=host&X-Goog-Signature=49d73db9bc1849459bfda7f2203925720ec40c83128264d3cee90d93506f03172f77cd45ae0261280a776618de48480773132c3854ddcce61f32d7f7ac567b7c0c0e3be660b13f91093a7bb5e58df2d202fdfee44354cd289855f240803ca66f51a2768c4f90133088430cc26c0678fba208e3228754db99dfbfdf9bd74cb5eb669d275be1e653be99e84a2a3bc3b75c17596c08ab3c8bf294d9cd01c61b669d61f72cacc7fbf5d05306c2c9c1cc245e7259a4c84f6e8bb21231922cd3838bc2ec672d3b163a34fe952d1afdc1d3f65f2d222863ba7fe11b58c4ac9438b93cdd069d29befb69c16534976528414b5f2145961ee9c1e78309b7e14a0da8a471a2";
  const String songName3 = "3Wii Music";
  const String artist3 = "3http://35.212.184.178/allusers/1/";
  const int start3 = 30;
  const int end3 = 315;
  const String song3 = "3https://storage.googleapis.com/songsnippetbucket/mp3s/Wii_Sports.mp3?X-Goog-Algorithm=GOOG4-RSA-SHA256&X-Goog-Credential=422381896818-compute%40developer.gserviceaccount.com%2F20221129%2Fauto%2Fstorage%2Fgoog4_request&X-Goog-Date=20221129T063904Z&X-Goog-Expires=86400&X-Goog-SignedHeaders=host&X-Goog-Signature=49d73db9bc1849459bfda7f2203925720ec40c83128264d3cee90d93506f03172f77cd45ae0261280a776618de48480773132c3854ddcce61f32d7f7ac567b7c0c0e3be660b13f91093a7bb5e58df2d202fdfee44354cd289855f240803ca66f51a2768c4f90133088430cc26c0678fba208e3228754db99dfbfdf9bd74cb5eb669d275be1e653be99e84a2a3bc3b75c17596c08ab3c8bf294d9cd01c61b669d61f72cacc7fbf5d05306c2c9c1cc245e7259a4c84f6e8bb21231922cd3838bc2ec672d3b163a34fe952d1afdc1d3f65f2d222863ba7fe11b58c4ac9438b93cdd069d29befb69c16534976528414b5f2145961ee9c1e78309b7e14a0da8a471a2";

  const testSongListResponseSingle = [
    {
      "songName": songName1,
      "artist": artist1,
      "start": start1,
      "end": end1,
      "song": song1
    }
  ];

  const testSongListResponse =
    [
      {
        "songName": songName1,
        "artist": artist1,
        "start": start1,
        "end": end1,
        "song": song1
      },
      {
        "songName": songName2,
        "artist": artist2,
        "start": start2,
        "end": end2,
        "song": song2
      },
      {
        "songName": songName3,
        "artist": artist3,
        "start": start3,
        "end": end3,
        "song": song3
      }
    ];

  test('always true', () {
    expect(0, 0);
  });

  test('list generated in order supplied', () {
    SongList songList = SongList.fromJson(testSongListResponse);
    expect(songName1, songList.songList[0].name);
    expect(artist1, songList.songList[0].artist);
    expect(start1, songList.songList[0].start);
    expect(end1, songList.songList[0].end);
    expect(song1, songList.songList[0].songUrl);

    expect(songName2, songList.songList[1].name);
    expect(artist2, songList.songList[1].artist);
    expect(start2, songList.songList[1].start);
    expect(end2, songList.songList[1].end);
    expect(song2, songList.songList[1].songUrl);

    expect(songName3, songList.songList[2].name);
    expect(artist3, songList.songList[2].artist);
    expect(start3, songList.songList[2].start);
    expect(end3, songList.songList[2].end);
    expect(song3, songList.songList[2].songUrl);
  });

  test('list of size one', () {
    SongList songList = SongList.fromJson(testSongListResponseSingle);
    expect(songName1, songList.songList[0].name);
    expect(artist1, songList.songList[0].artist);
    expect(start1, songList.songList[0].start);
    expect(end1, songList.songList[0].end);
    expect(song1, songList.songList[0].songUrl);
  });
}