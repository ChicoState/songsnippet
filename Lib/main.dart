import 'package:flutter/material.dart';
import 'Resources/theme.dart';
import 'Home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Root
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getTheme(),
      home: const Home(),
    );
  }
}