import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:one_futbol/database/team_dao.dart';
import 'package:one_futbol/models/player_model.dart';
import 'package:one_futbol/models/team_model.dart';

// ignore: must_be_immutable
class MatchDetails extends StatefulWidget {
  MatchDetails(
      {super.key,
      required this.teams,
      required this.match,
      required this.index});
  List<List<Team>> match;
  List<Team> teams;
  int index;

  @override
  State<MatchDetails> createState() => _MatchDetailsState();
}

GlobalKey<NavigatorState> historyNavigatorKey = GlobalKey<NavigatorState>();

typedef MenuEntry = DropdownMenuEntry<Player>;
typedef MenuEntry1 = DropdownMenuEntry<int>;

class _MatchDetailsState extends State<MatchDetails> {
  final dao = TeamDao();
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
        context: context,
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
        });
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
    List<Team> matches = widget.teams;
    return Column(
      children: [
        SizedBox(
          child: Card(
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
                    SizedBox(
                        width: 50,
                        height: 50,
                        child: FloatingActionButton(
                            heroTag: team.name,
                            child: Icon(
                              Icons.add,
                            ),
                            onPressed: () {
                              agregarGoles(team);
                            })),
                  ],
                )),
          ),
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
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;

    Team team1 = widget.teams[0];
    Team team2 = widget.teams[1];
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
                  dao.updateTeam(team2);
                  dao.updateTeam(team1);
                },
                label: Text('Finalizar'),
              )
            ],
          ),
        ));
  }
}
