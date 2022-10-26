import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../Utils/API_Utils/http_header_strings.dart';
import '../Response_Objects/song_list_object.dart';
import '../../../Utils/API_Utils/url_provider.dart';


Future<SongList> postSongFeedback(int musicID, bool like) async {
  const String keyMusicID = 'song';
  const String keyLikeID = 'like';
  final response = await http.post(
    Uri.parse(SongSnippetURLs.songFeedbackURL),
    headers: <String, String>{
      HTTPHeaderStrings.contentType : HTTPHeaderStrings.applicationEncoding,
    },
    body: jsonEncode(<String, String>{
      keyMusicID: musicID.toString(),
      keyLikeID: like.toString()
    }),
  );
  if (response.statusCode == 201) {
    return SongList.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to get list of songs, status code = ${response.statusCode}");
  }
}

