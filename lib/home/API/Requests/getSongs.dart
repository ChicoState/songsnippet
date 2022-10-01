import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'urlProvider.dart';
import 'httpHeaderStrings.dart';


Future<void> getSongList(int songCount) async {
  final response = await http.get(
    Uri.parse(SongSnippetURLs.songListURL),
    headers: <String, String>{
      HTTPHeaderStrings.contentType : HTTPHeaderStrings.applicationEncoding,
    },
  );
  if (response.statusCode == 201) {

  } else {
    throw Exception("Failed to get list of songs");
  }
}