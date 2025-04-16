import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:one_futbol/Views/Home/Widgets/Carta_widget.dart';
import 'package:one_futbol/Views/Home/Widgets/Score_board_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const AutoSizeText(
          "One Futbol",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(children: [
          SizedBox(height: 30),
          LogoSection(Logo: 'assets/image/one.png'),
          SizedBox(height: 40),
          Textotabla(),
          Marcador(),
          DatosCarta()
        ]),
      ),
    );
  }
}
