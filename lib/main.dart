import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_futbol/bloc/match_bloc/match_bloc.dart';
import 'package:one_futbol/bloc/match_bloc/match_event.dart';
import 'package:one_futbol/bloc/player_bloc/player_bloc.dart';
import 'package:one_futbol/bloc/player_bloc/player_event.dart';
import 'package:one_futbol/bloc/team_bloc/team_bloc.dart';
import 'package:one_futbol/bloc/team_bloc/team_event.dart';
import 'package:one_futbol/componentes/provider.dart';
import 'package:one_futbol/data/Repository/match_repository.dart';
import 'package:one_futbol/data/Repository/player_repository.dart';
import 'package:one_futbol/data/Repository/team_repository.dart';
import 'package:one_futbol/database/database_helper.dart';
import 'package:one_futbol/domain/funciones/generate_matches.dart';
import 'package:one_futbol/domain/funciones/generate_teams.dart';
import 'package:one_futbol/mianwrapper.dart';
import 'package:provider/provider.dart';

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
          create: (_) =>
              MatchBloc(matchRepository, generateMatches)..add(LoadMatches())),
      BlocProvider(
          create: (_) => PlayerBloc(playerRepository)..add(LoadPlayer())),
      BlocProvider(
          create: (_) =>
              TeamBloc(teamRepository, generateTeams)..add(LoadTeam())),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return ChangeNotifierProvider(
          create: (BuildContext context)=>UiProvider()..init(),
          child: Consumer<UiProvider>(
            builder: (context, UiProvider notifier, child) {
              return MaterialApp(
                themeMode: notifier.isDark? ThemeMode.dark : ThemeMode.light,
                darkTheme: notifier.isDark? notifier.darkTheme : notifier.lightTheme,
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFAC0202)),
                  useMaterial3: true,
                ),
                title: 'Una Pichanga Demo',
                home: MainWrapper(),
              );
            },
          ),
        );
      }
    );
  }
}
