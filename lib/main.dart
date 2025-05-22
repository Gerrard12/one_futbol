import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_futbol/bloc/match_bloc/match_bloc.dart';
import 'package:one_futbol/bloc/match_bloc/match_event.dart';
import 'package:one_futbol/bloc/player_bloc/player_bloc.dart';
import 'package:one_futbol/bloc/player_bloc/player_event.dart';
import 'package:one_futbol/bloc/team_bloc/team_bloc.dart';
import 'package:one_futbol/bloc/team_bloc/team_event.dart';
import 'package:one_futbol/data/Repository/match_repository.dart';
import 'package:one_futbol/data/Repository/player_repository.dart';
import 'package:one_futbol/data/Repository/team_repository.dart';
import 'package:one_futbol/database/database_helper.dart';
import 'package:one_futbol/domain/funciones/generate_matches.dart';
import 'package:one_futbol/domain/funciones/generate_teams.dart';
import 'package:one_futbol/mianwrapper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.init();
  final playerRepository = PlayerRepository();
  final matchRepository = MatchesRepository();
  final teamRepository = TeamRepository();
  final generateTeams = GenerateTeams();
  final generateMatches = GenerateMatches();

  runApp(MultiBlocProvider(
    providers: [
      
      BlocProvider(
          create: (_) => PlayerBloc(playerRepository)..add(LoadPlayer())),
      BlocProvider(
          create: (_) =>
              TeamBloc(teamRepository, generateTeams)..add(LoadTeam())),
              BlocProvider(
          create: (_) =>
              MatchBloc(matchRepository, generateMatches)..add(LoadMatches())),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Una Pichanga Demo',
      // theme: Provider.of<ThemeProvider>(context).themeData,
      home: MainWrapper(),
    );
  }
}
