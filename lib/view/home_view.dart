import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:one_futbol/domain/entities/match_model.dart';
import 'package:one_futbol/view/ajustes_view.dart';
import 'package:one_futbol/widget/Score_board_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    List<MatchModel> matches = [];

    return Scaffold(
      floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (_) => SettingView()));
              },
              child: const Icon(IconlyBold.setting),
            ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
              children: [
                SizedBox(height: 30),
                LogoSection(Logo: 'assets/image/logo.png',),
                SizedBox(height: 40),
                Textotabla(),
                Marcador(),
                TextoLista(),
                TablaGlobal(),
                SizedBox(height: 60),
                // DatosCarta(),
              ])),
      )
        );
  }
}
