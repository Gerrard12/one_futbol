import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:one_futbol/database/team_dao.dart';
import 'package:one_futbol/player_info.dart';
import 'package:one_futbol/team_model.dart';

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

typedef MenuEntry = DropdownMenuEntry<String>;

class _MatchDetailsState extends State<MatchDetails> {
  final dao = TeamDao();

  selectedItem(BuildContext context, item, int index) {
    switch (item) {
      case 0:
        agregarGoleador(index);
        break;
    }
  }

  Future<void> agregarGoleador(int index) async {
    TextEditingController goalController = TextEditingController(text: 'Goles');
    Team team = widget.match[widget.index][index];

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Añadir goleador'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: goalController,
                  decoration: InputDecoration(labelText: 'Goles'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.green)),
                  onPressed: () async {
                    team.points = double.tryParse(goalController.text) ?? 0;
                    await dao.updateTeamPoints(team, team.points);

                    setState(() {
                      widget.teams.sort(
                        (a, b) => b.points.compareTo(a.points),
                      );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Detalles del partido'),
        ),
        body: details());
  }

  @override
  Widget details() {
    List<Team> matches = widget.match[widget.index];
    return ListView.builder(
        itemCount: matches.length,
        itemBuilder: (context, index) {
          return SizedBox(
            child: Column(
              children: [
                SizedBox(
                  child: ListTile(
                    title: Text(
                      matches[index].name,
                      style: TextStyle(fontSize: 20),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        PopupMenuButton(
                          icon: Icon(
                            Icons.more_vert,
                            color: Colors.blueGrey,
                          ),
                          itemBuilder: (context) => [
                            PopupMenuItem(value: 0, child: Text('Agregar')),
                          ],
                          onSelected: (item) =>
                              selectedItem(context, item, index),
                        ),
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 1000),
                    height: 200,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: matches.length,
                      itemBuilder: (context, index2) {
                        return CardInfo(
                            players: matches[index2].teamPlayers, index: index);
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
