import 'package:http/http.dart' as http;

Future<String> uploadSong(
    filename, url, songName, artistName, year, startTime, endTime) async {
  var request = http.MultipartRequest('POST', Uri.parse(url));
  request.files.add(await http.MultipartFile.fromPath('song', filename));
  request.fields['start'] = startTime;
  request.fields['end'] = endTime;
  request.fields['artist'] = artistName;
  request.fields['song'] = songName;
  request.fields['year'] = year;
  var result = await request.send();
  return result.reasonPhrase!;
}
