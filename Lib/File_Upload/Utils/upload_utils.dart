import 'package:http/http.dart' as http;
import 'package:song_snippet/Utils/API_Utils/http_header_strings.dart';

Future<String> uploadSong(
    filename, url, songName, year, startTime, endTime) async {
  // final userRepo = UserRepository();
  // Token token = await userRepo.getCachedToken();
  var request = http.MultipartRequest('POST', Uri.parse(url));
  request.files.add(await http.MultipartFile.fromPath('song', filename));
  request.headers.addAll(
      {'Content-Type': 'multipart/form-data', 'Authorization': HTTPHeaderStrings.hardCodedToken});
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
