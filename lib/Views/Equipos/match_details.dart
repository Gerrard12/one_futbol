import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_futbol/Views/Equipos/matches.dart';
import 'package:one_futbol/bloc/match_bloc/match_bloc.dart';
import 'package:one_futbol/bloc/match_bloc/match_event.dart';
import 'package:one_futbol/bloc/match_bloc/match_state.dart';
import 'package:one_futbol/bloc/player_bloc/player_bloc.dart';
import 'package:one_futbol/bloc/player_bloc/player_event.dart';
import 'package:one_futbol/bloc/team_bloc/team_bloc.dart';
import 'package:one_futbol/bloc/team_bloc/team_event.dart';
import 'package:one_futbol/bloc/team_bloc/team_state.dart';
import 'package:one_futbol/domain/entities/match_model.dart';
import 'package:one_futbol/domain/entities/player_model.dart';
import 'package:one_futbol/domain/entities/team_model.dart';

class MatchDetails extends StatefulWidget {
  const MatchDetails({super.key, required this.match});
  final MatchModel match;

  @override
  State<MatchDetails> createState() => _MatchDetailsState();
}

GlobalKey<NavigatorState> historyNavigatorKey = GlobalKey<NavigatorState>();

typedef MenuEntry = DropdownMenuEntry<Player>;
typedef MenuEntry1 = DropdownMenuEntry<int>;

List<Player> playerBanned = [];
List<Team> winnerTeams = [];
List<Team> waitingTeams = [];
int bracketCount = 1;

bool isBanned = false;

class _MatchDetailsState extends State<MatchDetails> {
  TextEditingController controllerPlayer = TextEditingController();
  TextEditingController controllerGoals = TextEditingController();
  List<Player> goleadoresTeam1 = [];
  List<Player> goleadoresTeam2 = [];

  void agregarGoles(Team team) {
    List<Player> list = team.teamPlayers;

    final List<MenuEntry> menuEntries = UnmodifiableListView<MenuEntry>(
        list.map<MenuEntry>((e) => MenuEntry(
            value: e,
            label: e.name,
            style: ButtonStyle(alignment: Alignment.centerLeft))));

    Player dropdownValue = list.first;

    List<int> goal = List<int>.generate(
      10,
      (index) => index,
    );

    final List<MenuEntry1> goalsEntries =
        UnmodifiableListView<MenuEntry1>(goal.map<MenuEntry1>((e) => MenuEntry1(
            value: e,
            label: e.toString(),
            style: ButtonStyle(
              alignment: Alignment.center,
            ))));
    int dropdownValue1 = goal.first;

    showDialog(
        builder: (context) {
          return AlertDialog(
            title: Text('Agregar goles'),
            alignment: Alignment.center,
            content: Row(
              children: [
                DropdownMenu<Player>(
                  width: 180,
                  controller: controllerPlayer,
                  label: Text('Jugador'),
                  initialSelection: list.first,
                  onSelected: (Player? value) {
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                  dropdownMenuEntries: menuEntries,
                ),
                SizedBox(
                  width: 20,
                ),
                DropdownMenu<int>(
                  controller: controllerGoals,
                  width: 80,
                  menuHeight: 300,
                  label: Text('Goles'),
                  initialSelection: goal.first,
                  onSelected: (int? value1) {
                    setState(() {
                      dropdownValue1 = value1!;
                    });
                  },
                  dropdownMenuEntries: goalsEntries,
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.green)),
                  onPressed: () async {
                    if (dropdownValue.goals == 0) {
                      dropdownValue.goals = dropdownValue1;
                    } else {
                      team.teamGoals = team.teamGoals - dropdownValue.goals;
                      dropdownValue.goals = 0;
                      dropdownValue.goals = dropdownValue1;
                    }

                    setState(() {
                      setGoals(dropdownValue);
                      teamGoals(dropdownValue, team);
                      Navigator.pop(context);
                      dropdownValue1 = 0;
                    });
                  },
                  child: Text('Guardar',
                      style: TextStyle(
                        color: Colors.white,
                      ))),
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancelar')),
            ],
          );
        },
        context: context);
  }

  void setGoals(Player player) {
    setState(() {
      player.goals;
    });
  }

  void teamGoals(Player player, Team team) {
    setState(() {
      for (var i = 0; i < player.goals; i++) {
        team.teamGoals++;
      }
    });
  }

  Widget details(Team team) {
    for (Player player in team.teamPlayers) {
      if (team.teamGoals == 0) {
        player.goals = 0;
      }
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            child: ListTile(
                title: Text(
                  team.name,
                  style: TextStyle(fontSize: 20),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Goles totales: ${team.teamGoals.toString()}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    FloatingActionButton.small(
                        heroTag: team.name,
                        child: Icon(
                          Icons.add,
                        ),
                        onPressed: () {
                          agregarGoles(team);
                        }),
                    FloatingActionButton.small(
                        heroTag: team.teamPlayers,
                        child: Icon(Icons.person_off_outlined),
                        onPressed: () {
                          playerPunishment(team);
                        })
                  ],
                )),
          ),
          Column(
            children: team.teamPlayers
                .map((e) => e.goals > 0
                    ? Card(
                        child: ListTile(
                          title: Text(e.name),
                          trailing: Text(
                            'Goles ${e.goals.toString()}',
                            style: TextStyle(fontSize: 16),
                          ),
                          subtitle: Text(e.position),
                        ),
                      )
                    : SizedBox())
                .toList(),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  void playerPunishment(Team team) {
    List<Player> list = team.teamPlayers;

    final List<MenuEntry> menuEntries = UnmodifiableListView<MenuEntry>(
        list.map<MenuEntry>((e) => MenuEntry(
            value: e,
            label: e.name,
            style: ButtonStyle(alignment: Alignment.centerLeft))));

    Player dropdownValue = list.first;

    showDialog(
        builder: (context) {
          return AlertDialog(
            title: Text('Jugadores que no asistieron'),
            alignment: Alignment.center,
            content: DropdownMenu<Player>(
              width: 180,
              controller: controllerPlayer,
              label: Text('Jugador'),
              initialSelection: list.first,
              onSelected: (Player? value) {
                setState(() {
                  dropdownValue = value!;
                });
              },
              dropdownMenuEntries: menuEntries,
            ),
            actions: [
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.green)),
                  onPressed: () {
                    setState(() {
                      playerBanned.add(dropdownValue);
                      for (Player player in playerBanned) {
                        player.status = 'Baneado';
                        context.read<PlayerBloc>().add(UpdatePlayer(player));
                      }
                    });
                    Navigator.pop(context);
                  },
                  child: Text('Guardar',
                      style: TextStyle(
                        color: Colors.white,
                      ))),
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancelar')),
            ],
          );
        },
        context: context);
  }

  Future<void> finalizar(
    MatchModel match,
  ) async {
    if (match.teams[0].teamGoals > match.teams[1].teamGoals) {
      match.teams[0].points += 3;
      winnerTeams.add(match.teams[0]);
    } else if (match.teams[0].teamGoals < match.teams[1].teamGoals) {
      match.teams[1].points += 3;
      winnerTeams.add(match.teams[1]);
    } else {
      match.teams[0].points += 1;
      match.teams[1].points += 1;
    }
    match.status = 'Finalizado';
    context.read<TeamBloc>().add(UpdateTeam(match.teams[0]));
    context.read<TeamBloc>().add(UpdateTeam(match.teams[1]));
    context.read<TeamBloc>().add(LoadTeam());
    context.read<MatchBloc>().add(UpdateMatch(match));
  }

  @override
  Widget build(BuildContext context) {
    MatchModel match = widget.match;

    return Scaffold(
        appBar: AppBar(
          title: Text('Detalles del partido'),
        ),
        body: Column(
          children: [
            SizedBox(height: 20),
            ListView.builder(
              itemCount: 2,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return details(match.teams[index]);
              },
            ),
            FloatingActionButton.extended(
              heroTag: sqrt1_2,
              onPressed: () async {
                Navigator.pop(context);
                finalizar(match);
                createNewMatches(match, context);
                winnerTeams.clear();
              },
              label: Text('Finalizar'),
            )
          ],
        ));
  }
}
