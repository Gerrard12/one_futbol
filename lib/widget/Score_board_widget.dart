import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_futbol/bloc/drawer_event.dart';
import 'package:one_futbol/bloc/nav_drawer_bloc.dart';
import 'package:one_futbol/bloc/nav_drawer_state.dart';
import 'package:one_futbol/widget/live_match_box.dart';
import 'package:one_futbol/widget/upcoming_widget.dart';

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
    return SizedBox(
      height: 250,
      child: ListView(
        shrinkWrap: true,
        primary: false,
        scrollDirection: Axis.horizontal,
        children: [
          LiveMatchBox(
            awayGoal: 3,
            homeGoal: 0,
            time: 83,
            awayLogo: 'assets/image/real.png',
            homeLogo: 'assets/image/Barca.png',
            awayTitle: 'Los Capos',
            homeTitle: 'Chumbeles',
            color: const Color(0xFF1D1D1D),
            textColor: Colors.white,
            numColor: Colors.amber,
            backgroundImage: DecorationImage(
              image: AssetImage('assets/image/pl.png'),
              fit: BoxFit.contain,
              alignment: Alignment.bottomLeft,
              opacity: 0.3,
            ),
          ),
          LiveMatchBox(
            awayGoal: 3,
            homeGoal: 0,
            time: 83,
            awayLogo: 'assets/image/real.png',
            homeLogo: 'assets/image/Barca.png',
            awayTitle: 'Los Capos',
            homeTitle: 'Chumbeles',
            color: const Color(0x75FFFFFF),
            textColor: Colors.black,
            numColor: Colors.pink,
            backgroundImage: DecorationImage(
              image: AssetImage('assets/image/pl.png'),
              fit: BoxFit.contain,
              alignment: Alignment.bottomLeft,
              opacity: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}

class TextoLista extends StatelessWidget {
  const TextoLista({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Text(
            'Partidos Preparados',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {
              BlocProvider.of<NavDrawerBloc>(context)
                  .add(const NavigateTo(NavItem.orderView));
            },
            child: Text('See all'),
          ),
        ],
      ),
    );
  }
}

class TablaGlobal extends StatelessWidget {
  const TablaGlobal({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        shrinkWrap: true,
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          UpComingMatch(
            awayLogo: 'assets/image/real.png',
            awayTitle: 'Los Capos',
            homeLogo: 'assets/image/Barca.png',
            homeTitle: 'Chumbeles',
            date: '30 Dic',
            time: '06:30',
            isFavorite: true,
            textColor: Colors.white,
          ),
          UpComingMatch(
            awayLogo: 'assets/image/real.png',
            awayTitle: 'Los Capos',
            homeLogo: 'assets/image/Barca.png',
            homeTitle: 'Chumbeles',
            date: '30 Dic',
            time: '06:30',
            isFavorite: true,
            textColor: Colors.white,
          ),
          UpComingMatch(
            awayLogo: 'assets/image/real.png',
            awayTitle: 'Los Capos',
            homeLogo: 'assets/image/Barca.png',
            homeTitle: 'Chumbeles',
            date: '30 Dic',
            time: '06:30',
            isFavorite: true,
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}

class LogoSection extends StatelessWidget {
  const LogoSection({super.key, required this.Logo});

  final String Logo;

  @override
  Widget build(BuildContext context) {
    return Image.asset(Logo, width: 400, height: 300, fit: BoxFit.cover);
  }
}
