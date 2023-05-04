import 'package:flutter/material.dart';
import 'package:pip_flutter/home_page.dart';

final aspectRatios = [
  [1, 1],
  [2, 3],
  [3, 2],
  [9, 16],
  [16, 9],
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}
