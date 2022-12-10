import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../resources/strings.dart';
import '../Response_Objects/song_list_object.dart';
import '../../../Utils/API_Utils/url_provider.dart';
import '../../../Utils/API_Utils/http_header_strings.dart';
import '../Response_Objects/song_object.dart';

Future<SongList> getSongList() async {
  final response = await http.get(
    Uri.parse(SongSnippetURLs.songListURL),
    headers: <String, String>{
      HTTPHeaderStrings.contentType: HTTPHeaderStrings.applicationEncoding,
      HttpHeaders.authorizationHeader: HTTPHeaderStrings.hardCodedToken
    },
  );
  if (response.statusCode == 200) {
    return SongList.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(
        "Failed to get list of songs, status code = ${response.statusCode}");
  }
}

Future<SongObject> getInitialSongRecommendations() async {
  final response = await http.get(
    Uri.parse(SongSnippetURLs.songInitialRecURL),
    headers: <String, String>{
      HTTPHeaderStrings.contentType: HTTPHeaderStrings.applicationEncoding,
      HttpHeaders.authorizationHeader: HTTPHeaderStrings.hardCodedToken
    },
  );
  if (response.statusCode == 200) {
    return SongObject.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 204) {
    throw Exception(
        SongSnippetStrings.noSongException
    );
  } else {
    throw Exception(
        "Failed to get song, status code = ${response.statusCode}"
    );
  }
}
