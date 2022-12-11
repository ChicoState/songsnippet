import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../Bloc_Login/Repository/user_repository.dart';
import '../../../Bloc_Login/Model/api_model.dart';
import '../../../Resources/strings.dart';
import '../../../Utils/API_Utils/http_header_strings.dart';
import '../../../Utils/API_Utils/url_provider.dart';
import '../Response_Objects/song_object.dart';


Future<SongObject> postSongFeedback(int musicID, bool like) async {
  final userRepository = UserRepository();
  Token token = await userRepository.getCachedToken();
  const String keyMusicID = 'song';
  const String keyLikeID = 'like';
  final response = await http.post(
    Uri.parse(SongSnippetURLs.songFeedbackURL),
    headers: <String, String>{
      HTTPHeaderStrings.contentType : HTTPHeaderStrings.applicationEncoding,
      HttpHeaders.authorizationHeader: token.token
    },
    body: jsonEncode(<String, dynamic>{
      keyMusicID: musicID,
      keyLikeID: like
    }),
  );
  if (response.statusCode == 201) {
    return SongObject.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 204) {
    throw Exception(SongSnippetStrings.noSongException);
  } else {
    throw Exception(response.statusCode);
  }
}

