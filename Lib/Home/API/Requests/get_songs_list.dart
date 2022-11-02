import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../Response_Objects/song_list_object.dart';
import '../../../Utils/API_Utils/url_provider.dart';
import '../../../Utils/API_Utils/http_header_strings.dart';
import '../../../Login/API/Requests/get_user_object.dart';
import '../../../Model/api_model.dart';
import '../../../Repository/user_repository.dart';

Future<SongList> getSongList() async {
  final userRepository = UserRepository();
  Token token = await userRepository.getCachedToken();
  print(token);
  final response = await http.get(
    Uri.parse(SongSnippetURLs.songListURL),
    headers: <String, String>{
      HTTPHeaderStrings.contentType: HTTPHeaderStrings.applicationEncoding,
      HttpHeaders.authorizationHeader: token.token
    },
  );
  if (response.statusCode == 200) {
    return SongList.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(
        "Failed to get list of songs, status code = ${response.statusCode}");
  }
}

Future<SongList> getInitialSongRecommendations(int count) async {
  const String keyCount = 'count';
  final response = await http.post(
    Uri.parse(SongSnippetURLs.songListURL),
    headers: <String, String>{
      HTTPHeaderStrings.contentType: HTTPHeaderStrings.applicationEncoding,
      HttpHeaders.authorizationHeader: 'TOKEN b03cdb0207d3769420b392838c980d23e431877e'
    },
    body: jsonEncode(<String, int>{
      keyCount: count,
    }),
  );
  if (response.statusCode == 200) {
    return SongList.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 204) {
    throw Exception(
      "No more songs to recommend"
    );
  } else {
    throw Exception(
        "Failed to get list of songs, status code = ${response.statusCode}"
    );
  }
}
