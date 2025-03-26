import 'package:flutter/material.dart';
import 'package:one_futbol/Navigation_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const Banner(
        message: '',
        location: BannerLocation.topEnd,
        child: MainWrapper(),
      ),
    );
  }
}