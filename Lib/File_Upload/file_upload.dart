import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:song_snippet/File_Upload/file_form_field.dart';
import 'form_utils.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
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

  String state = "";
  late File file;
  final _formKey = GlobalKey<FormState>();
  final songController = TextEditingController();
  final artistController = TextEditingController();
  final timeStartController = TextEditingController();
  final timeEndController = TextEditingController();
  final yearController = TextEditingController();

  @override
  void dispose() {
    songController.dispose();
    artistController.dispose();
    timeStartController.dispose();
    timeEndController.dispose();
    yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("upload test"),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                //song
                controller: songController,
                validator: (value) {
                  if (value!.isEmpty || value.isValidName) {
                    return 'Please enter a valid song name';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Song Name',
                  hintText: 'Song Name',
                ),
              ),
              TextFormField(
                controller: artistController,
                validator: (value) {
                  if (value!.isEmpty || value.isValidName) {
                    return 'Please enter a valid artist name';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Artist Name',
                  hintText: 'Artist Name',
                ),
              ),
              TextFormField(
                controller: yearController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a valid year';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Release Year',
                  hintText: '2000',
                ),
              ),
              TextFormField(
                controller: timeStartController,
                validator: (value) {
                  if (value!.isEmpty || value.isValidTime) {
                    return 'Please enter a valid start time';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: '"Start Time',
                  hintText: 'Start Time (in seconds)',
                ),
              ),
              TextFormField(
                controller: timeEndController,
                validator: (value) {
                  if (value!.isEmpty || value.isValidTime) {
                    return 'Please enter a valid end time';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'End Time',
                  hintText: 'End Time (in seconds)',
                ),
              ),
              FileFormField(validator: (val) {
                if (val == null) return 'Pick a valid song';
                return null;
              }, onChanged: (item) {
                file = item;
              }),
              FloatingActionButton(onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  var res = await uploadSong(
                      file.path,
                      widget.url,
                      songController.text,
                      artistController.text,
                      yearController.text,
                      timeStartController.text,
                      timeEndController.text);
                  setState(() {
                    state = res;
                  });
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
