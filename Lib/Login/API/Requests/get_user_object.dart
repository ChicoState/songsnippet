import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../Login/API/Response/user_object.dart';
import '../../../Model/api_model.dart';
import '../../../Utils/API_Utils/url_provider.dart';

final _base = "https://home-hub-app.herokuapp.com";
final _tokenEndpoint = "/api-token-auth/";
final _tokenURL = _base + _tokenEndpoint;

Future<Token> getToken(UserLogin userLogin) async {
  print(Uri.parse(SongSnippetURLs.songSnippetLogin));
  final http.Response response = await http.post(
    Uri.parse(SongSnippetURLs.songSnippetLogin),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(userLogin.toDatabaseJson()),
  );
  if (response.statusCode == 200) {

    return Token.fromJson(json.decode(response.body));
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}