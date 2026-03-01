import 'package:flutter/material.dart';
import 'package:myapp/presentation/view/random_number_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter MVVM Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RandomNumberScreen(),
    );
  }
}
