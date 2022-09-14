import 'package:flutter/material.dart';
import 'theme/theme.dart';
import 'home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Root
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Song Snippet',
      theme: getTheme(),
      home: const Home(),
    );
  }
}