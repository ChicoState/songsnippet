import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../Resources/dimen.dart';

class FileFormField extends StatelessWidget {
  FileFormField({
    Key? key,
    required this.validator,
    required this.onChanged,
  }) : super(key: key);

  final String? Function(File?) validator;
  final Function(File) onChanged;
  File? _pickedFile;

  @override
  Widget build(BuildContext context) {
    return FormField<File>(
        validator: validator,
        builder: (formFieldState) {
          return Column(
            children: [
              GestureDetector(
                onTap: () async {
                  FilePickerResult? file = await FilePicker.platform
                      .pickFiles(type: FileType.audio, allowMultiple: false);
                  if (file != null) {
                    _pickedFile = File(file.files.first.path!);
                    onChanged.call(_pickedFile!);
                  }
                },
                child: Container(
                  margin: const EdgeInsets.all(SongSnippetDimen.padding),
                  padding: const EdgeInsets.symmetric(
                      horizontal: SongSnippetDimen.padding3x,
                      vertical: SongSnippetDimen.padding),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(SongSnippetDimen.padding),
                  ),
                  child: Column(
                    children: const [
                      Icon(Icons.upload_file),
                      Text('Upload Song'),
                    ],
                  ),
                ),
              ),
              if (formFieldState.hasError)
                Padding(
                  padding: const EdgeInsets.only(
                      left: SongSnippetDimen.padding,
                      top: SongSnippetDimen.padding2x),
                  child: Text(
                    formFieldState.errorText!,
                    style: const TextStyle(
                        fontStyle: FontStyle.normal,
                        fontSize: 13,
                        color: Colors.red,
                        height: 0.5),
                  ),
                )
            ],
          );
        });
  }
}
