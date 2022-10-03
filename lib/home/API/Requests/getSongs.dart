import 'dart:convert';
import 'package:http/http.dart' as http;
import '../ResponseObjects/songListObject.dart';
import 'urlProvider.dart';
import 'httpHeaderStrings.dart';


Future<SongList> getSongList() async {
  final response = await http.get(
    Uri.parse(SongSnippetURLs.songListURL),
    headers: <String, String>{
      HTTPHeaderStrings.contentType : HTTPHeaderStrings.applicationEncoding,
    },
  );
  if (response.statusCode == 200) {
    return SongList.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to get list of songs, status code = ${response.statusCode}");
  }
}