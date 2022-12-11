import 'package:flutter/material.dart';
import 'colors.dart';

ThemeData getTheme() {
  return ThemeData(
      primaryColor: SongSnippetColors.creamsicle,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: SongSnippetColors.burgandy,
      ));
}
