import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../Model/api_model.dart';
import '../../../../Utils/API_Utils/url_provider.dart';

const _base = SongSnippetURLs.songSnippetURL;
const _tokenEndpoint = "/api-token-auth/";
const _tokenURL = _base + _tokenEndpoint;
const _adminUsername = 'dongo2';
const _adminPassword = 'nopassword';
const _signUpEndpoint = "user/";
const _signUpUrl = _base + _signUpEndpoint;

Future<Token> getToken(UserLogin userLogin) async {
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
    throw Exception(json.decode(response.body));
  }
}

Future<String> getAdminToken() async {
  final UserLogin admin =
      UserLogin(username: _adminUsername, password: _adminPassword);
  final Token token = await getToken(admin);
  return token.token.toString();
}

Future<UserLogin> registerUser(UserSignup userSignup) async {
  final String adminToken = await getAdminToken();
  final http.Response response = await http.post(
    Uri.parse(_signUpUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'TOKEN $adminToken'
    },
    body: jsonEncode(userSignup.toDatabaseJson()),
  );
  if (response.statusCode == 201) {
    final UserLogin user = UserLogin(
        username: userSignup.user.username, password: userSignup.user.password);
    return user;
  } else {
    throw Exception(json.decode(response.body));
  }
}
