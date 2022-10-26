import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:song_snippet/Utils/API_Utils/url_provider.dart';
import 'package:song_snippet/Login/API/Model/login_object.dart';


Future<Token> login(String user, String password) async {
  const usernameKey = "username";
  const passwordKey = "password";
  final http.Response response = await http.post(
    Uri.parse(SongSnippetURLs.loginURL),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String,String>{usernameKey:user, passwordKey:password}),
  );
  if (response.statusCode == 200) {
    return Token.fromJson(json.decode(response.body));
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}