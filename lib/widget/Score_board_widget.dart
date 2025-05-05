import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:one_futbol/domain/entities/match_model.dart';
import 'package:one_futbol/domain/entities/team_model.dart';

class Textotabla extends StatelessWidget {
  const Textotabla({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: Text('Tabla del Partido Anterior')),
              ],
            ),
            Divider()
          ],
        ),
      ),
    );
  }
}

class Marcador extends StatelessWidget {
  final List<MatchModel> matches;

  const Marcador({super.key, required this.matches});

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;

    return ListView.builder(
      shrinkWrap: true,
      itemCount: matches.length,
      itemBuilder: (BuildContext context, int index) {
        List<Team> m = matches[index].teams;

        return Card.outlined(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          margin: EdgeInsets.all(20),
          color: Color.fromARGB(87, 211, 214, 186),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SizedBox(
              height: heightScreen * 0.18,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: AutoSizeText(
                        'Fecha de encuentro - Mie, 12/3',
                      )),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                          ),
                          AutoSizeText(
                            'Finalizado',
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child:
                              Image.asset('assets/image/real.png', scale: 5)),
                      Row(
                        children: [
                          AutoSizeText(m[0].teamGoals.toString(),
                              style: TextStyle(fontSize: 30)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 50),
                            child: AutoSizeText('-'),
                          ),
                          AutoSizeText(m[1].teamGoals.toString(),
                              style: TextStyle(fontSize: 30)),
                          Image.asset(
                            'assets/image/Barca.png',
                            scale: 8,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      AutoSizeText(m[0].name),
                      Padding(
                        padding: EdgeInsets.only(right: 185),
                      ),
                      AutoSizeText(m[1].name),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class LogoSection extends StatelessWidget {
  const LogoSection({super.key, required this.Logo});

  final String Logo;

  @override
  Widget build(BuildContext context) {
    return Image.asset(Logo, width: 300, height: 200, fit: BoxFit.cover);
  }
}
