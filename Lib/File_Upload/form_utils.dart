import 'package:http/http.dart' as http;

extension ExtString on String {
  bool get isValidName {
    final nameRegExp =
        RegExp(r"^\s*([A-Za-z]{1,}([].,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(this);
  }

  bool get isValidTime {
    final timeRegExp = RegExp(r"^\+?0[0-0]$");
    return timeRegExp.hasMatch(this);
  }
}

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
