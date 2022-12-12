import 'package:flutter/material.dart';
import 'dart:io';
import 'package:song_snippet/File_Upload/file_form_field.dart';
import '../main.dart';
import 'form_utils.dart';
import 'Utils/upload_utils.dart';
import '../Utils/API_Utils/url_provider.dart';
import '../Resources/dimen.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> with RouteAware {
  String state = "";
  late File file;
  final _formKey = GlobalKey<FormState>();
  final songController = TextEditingController();
  final timeStartController = TextEditingController();
  final timeEndController = TextEditingController();
  final yearController = TextEditingController();

  @override
  void dispose() {
    songController.dispose();
    timeStartController.dispose();
    timeEndController.dispose();
    yearController.dispose();
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didChangeDependencies () {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Song"),
      ),
      body: SafeArea(
        minimum:
            const EdgeInsets.symmetric(horizontal: SongSnippetDimen.padding),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: songController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a song name';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Song Name',
                  hintText: 'Song Name',
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
                  if (value!.isEmpty || isNumber(value)) {
                    return 'Please enter a whole number value';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Start Time',
                  hintText: 'Start Time (in seconds)',
                ),
              ),
              TextFormField(
                controller: timeEndController,
                validator: (value) {
                  if (value!.isEmpty || isNumber(value)) {
                    return 'Please enter a whole number value';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'End Time',
                  hintText: 'End Time (in seconds)',
                ),
              ),
              FileFormField(
                validator: (val) {
                  if (val == null) return 'Pick a valid song';
                  return "";
                },
                onChanged: (item) {
                  file = item;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    var res = await uploadSong(
                        file.path,
                        SongSnippetURLs.songUpload,
                        songController.text,
                        yearController.text,
                        timeStartController.text,
                        timeEndController.text);
                    setState(() {
                      state = res;
                    });
                  } catch (e) {
                    rethrow;
                  }
                },
                child: const Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
