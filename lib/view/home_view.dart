import 'package:flutter/material.dart';
import 'package:one_futbol/widget/Carta_widget.dart';
import 'package:one_futbol/widget/Score_board_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: SingleChildScrollView(
          child: Column(
              children: [
                SizedBox(height: 30),
                LogoSection(Logo: 'assets/image/logo1.png'),
                SizedBox(height: 40),
                Textotabla(),
                Marcador(),
                DatosCarta(),
              ])),
      )
        );
  }
}
