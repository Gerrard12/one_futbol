import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_futbol/bloc/match_bloc/match_bloc.dart';
import 'package:one_futbol/bloc/match_bloc/match_state.dart';
import 'package:one_futbol/domain/entities/match_model.dart';
import 'package:one_futbol/widget/Carta_widget.dart';
import 'package:one_futbol/widget/Score_board_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<MatchBloc>().state;
    List<MatchModel>? matches;

    if (state is MatchLoaded) {
      if (state.matches.isNotEmpty) {
        matches = state.matches;
      }
    }
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
          child: Column(children: [
        SizedBox(height: 30),
        LogoSection(Logo: 'assets/image/logo1.png'),
        SizedBox(height: 40),
        Textotabla(),
        matches != null
            ? Marcador(
                match: matches.first,
              )
            : SizedBox(),
        DatosCarta(),
      ])),
    ));
  }
}
