import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Response_Objects/song_list_object.dart';
import '../../../Utils/API_Utils/url_provider.dart';
import '../../../Utils/API_Utils/http_header_strings.dart';


Future<SongList> getSongList() async {
  final response = await http.get(
    Uri.parse(SongSnippetURLs.songListURL),
    headers: <String, String>{
      HTTPHeaderStrings.contentType : HTTPHeaderStrings.applicationEncoding,
    },
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    return SongList.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to get list of songs, status code = ${response.statusCode}");
  }
}