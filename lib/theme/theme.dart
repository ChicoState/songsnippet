import 'package:flutter/material.dart';
import 'colors.dart';



ThemeData getTheme() {
  return ThemeData(
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: SongSnippetColors.burgandy,
      primaryColorDark: SongSnippetColors.maple,
    )
  );
}