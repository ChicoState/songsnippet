import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


Future<Token> login(String user, String password) async {
  final http.Response response = await http.post(
    loginURL,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String,String>{usernameKey:user, passwordKey:password})),
  );
  if (response.statusCode == 200) {
    return Token.fromJson(json.decode(response.body));
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }


  static const usernameKey = "username"
  static const passwordKey = "password"
}