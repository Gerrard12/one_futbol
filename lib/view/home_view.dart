import 'package:flutter/material.dart';
import 'package:one_futbol/Views/Equipos/matches.dart';
import 'package:one_futbol/data/data_provider/match_dao.dart';
import 'package:one_futbol/domain/entities/match_model.dart';
import 'package:one_futbol/widget/Carta_widget.dart';
import 'package:one_futbol/widget/Score_board_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    List<MatchModel> matches = [];

    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
          child: Column(children: [
        SizedBox(height: 30),
        LogoSection(Logo: 'assets/image/logo1.png'),
        SizedBox(height: 40),
        Textotabla(),
        Marcador(
          matches: matches,
        ),
        DatosCarta(),
      ])),
    ));
  }
}
