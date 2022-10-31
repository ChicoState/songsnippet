import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:song_snippet/Utils/API_Utils/http_header_strings.dart';

Future<String> uploadSong(
    filename, url, songName, artistName, year, startTime, endTime) async {
  var request = http.MultipartRequest('POST', Uri.parse(url));
  request.files.add(await http.MultipartFile.fromPath('song', filename));
  request.headers['authorization'] =
      'TOKEN b03cdb0207d3769420b392838c980d23e431877e';
  request.fields['start'] = startTime;
  request.fields['end'] = endTime;
  request.fields['artist'] = artistName;
  request.fields['song'] = songName;
  request.fields['year'] = year;
  var result = await request.send();
  return result.reasonPhrase!;
}
