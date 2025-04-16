import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

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
  const Marcador({super.key});

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: EdgeInsets.all(20),
      color: Color.fromARGB(87, 211, 214, 186),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: AutoSizeText('Fecha de encuentro - Mie, 12/3')),
                Row(
                  children: [
                    AutoSizeText(''),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                    ),
                    AutoSizeText('Finalizado'),
                  ],
                ),
              ],
            ),
            Divider(
              color: Colors.black,
            ),
            Row(
              children: [
                Expanded(child: Image.asset('assets/image/real.png', scale: 5)),
                Row(
                  children: [
                    AutoSizeText('3', style: TextStyle(fontSize: 30)),
                    Padding(
                      child: AutoSizeText('-'),
                      padding: EdgeInsets.symmetric(horizontal: 50),
                    ),
                    AutoSizeText('1', style: TextStyle(fontSize: 30)),
                    Image.asset(
                      'assets/image/Barca.png',
                      scale: 7,
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                AutoSizeText('Jaraneros'),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 96),
                ),
                AutoSizeText('Chumbeles'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LogoSection extends StatelessWidget {
  const LogoSection({super.key, required this.Logo});

  final String Logo;

  @override
  Widget build(BuildContext context) {
    return Image.asset(Logo, width: 100, height: 100, fit: BoxFit.cover);
  }
}
