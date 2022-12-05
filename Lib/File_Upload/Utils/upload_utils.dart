import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:song_snippet/Utils/API_Utils/http_header_strings.dart';

Future<String> uploadSong(
    filename, url, songName, year, startTime, endTime) async {
  var request = http.MultipartRequest('POST', Uri.parse(url));
  request.files.add(await http.MultipartFile.fromPath('song', filename));
  print(filename);
  print(request.files.first.length);
  request.headers.addAll({
    'Content-Type': 'multipart/form-data',
    'Authorization': 'TOKEN b03cdb0207d3769420b392838c980d23e431877e'
  });
  Map<String, String> fields = {
    'songName': songName,
    'start': startTime,
    'end': endTime,
    'year': year
  };
  request.fields.addAll(fields);
  var result = await request.send();
  if (result.statusCode == 201 || result.statusCode == 200) {
    return "Success";
  } else {
    throw Exception("Error uploading file, status code: ${result.statusCode}");
  }
}
