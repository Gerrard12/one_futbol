import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_futbol/bloc/match_bloc/match_bloc.dart';
import 'package:one_futbol/bloc/match_bloc/match_event.dart';
import 'package:one_futbol/bloc/match_bloc/match_state.dart';
import 'package:one_futbol/bloc/team_bloc/team_bloc.dart';
import 'package:one_futbol/bloc/team_bloc/team_event.dart';
import 'package:one_futbol/data/data_provider/match_dao.dart';
import 'package:one_futbol/data/data_provider/team_dao.dart';
import 'package:one_futbol/domain/entities/match_model.dart';
import 'package:one_futbol/domain/entities/player_model.dart';
import 'package:one_futbol/domain/entities/team_model.dart';

class MatchDetails extends StatefulWidget {
  MatchDetails({
    super.key,
    required this.matches,
    required this.index,
  });
  List<MatchModel> matches;
  int index;

  @override
  State<MatchDetails> createState() => _MatchDetailsState();
}

GlobalKey<NavigatorState> historyNavigatorKey = GlobalKey<NavigatorState>();

typedef MenuEntry = DropdownMenuEntry<Player>;
typedef MenuEntry1 = DropdownMenuEntry<int>;

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
      9,
      (index) => index + 1,
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

  @override
  Widget build(BuildContext context) {
    List<Team> teams = widget.matches[widget.index].teams;
    MatchModel match = widget.matches[widget.index];

    return Scaffold(
        appBar: AppBar(
          title: Text('Detalles del partido'),
        ),
        body: SizedBox(
          height: heightScreen - 170,
          child: Column(
            children: [
              Expanded(child: details(team1)),
              Divider(),
              Expanded(child: details(team2)),
              FloatingActionButton.extended(
                heroTag: sqrt1_2,
                onPressed: () {
                  Navigator.pop(context);
                  if (team2.teamGoals > team1.teamGoals) {
                    team2.points += 3;
                  }
                  if (team2.teamGoals == team1.teamGoals) {
                    team2.points += 1;
                    team1.points += 1;
                  } else {
                    team1.points += 3;
                  }
                },
                label: Text('Finalizar'),
              )
            ],
          ),
        ));
  }
}
