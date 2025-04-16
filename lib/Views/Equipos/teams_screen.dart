import 'package:flutter/material.dart';
import 'package:one_futbol/database/player_dao.dart';
import 'package:one_futbol/database/team_dao.dart';
import 'package:one_futbol/Views/Equipos/matches.dart';
import 'package:one_futbol/models/player_model.dart';
import 'package:one_futbol/models/team_model.dart';

// ignore: must_be_immutable
class Teams extends StatefulWidget {
  List<Team> teams;

  Teams({super.key, required this.teams});

  @override
  State<Teams> createState() => _TeamsState();
}

class _TeamsState extends State<Teams> {
  final daoTeam = TeamDao();
  final dao = PlayerDao();

  @override
  void initState() {
    super.initState();
    updateTeams();
  }

  Future<void> updateTeams() async {
    widget.teams = await daoTeam.readAllTeam();
    setState(() {});
  }

  Future<void> eliminarteams(Team list) async {
    await daoTeam.deleteTeam(list);
    updateTeams();
  }

  Future<void> editarteams(Team list) async {
    TextEditingController nameController =
        TextEditingController(text: list.name);
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Editar equipo'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      labelText: 'Nombre del equipo'),
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.green)),
                  onPressed: () async {
                    list.name = nameController.text;
                    daoTeam.updateTeamName(list, list.name);
                    updateTeams();
                    setState(() {
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
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Teams'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          children: [
            FloatingActionButton.small(
              heroTag: 1,
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Matches(
                              team: widget.teams,
                            )));
              },
              child: const Icon(Icons.account_tree_rounded),
            ),
            Column(
              children: widget.teams.map(
                (team) {
                  return DragTarget<Player>(
                    onAcceptWithDetails: (player) async {
                      setState(() {
                        for (var team in widget.teams) {
                          team.teamPlayers.removeWhere(
                            (element) => element.id == player.data.id,
                          );
                          daoTeam.updateTeam(team);
                        }
                        player.data.team_id = team.id;
                        team.teamPlayers.add(player.data);
                        dao.update(player.data);
                        daoTeam.updateTeam(team);
                      });
                      updateTeams();
                    },
                    builder: (context, candidateData, rejectedData) {
                      return Column(
                        children: [
                          ListTile(
                            title: Text(team.name),
                            trailing: PopupMenuButton(
                              icon: Icon(
                                Icons.more_vert,
                                color: Colors.blueGrey,
                              ),
                              itemBuilder: (context) => [
                                PopupMenuItem(value: 0, child: Text('Editar')),
                                PopupMenuItem(
                                    value: 1, child: Text('Eliminar')),
                              ],
                              onSelected: (item) =>
                                  selectedItem(context, item, team),
                            ),
                          ),
                          ListView(
                              shrinkWrap: true,
                              children: team.teamPlayers.map((player) {
                                return Draggable<Player>(
                                  data: player,
                                  feedback: Container(
                                      padding: EdgeInsets.all(20),
                                      height: heightScreen / 8,
                                      width: widthScreen - 5,
                                      constraints:
                                          BoxConstraints.tightForFinite(),
                                      child: Card(
                                          child: ListTile(
                                        title: Text(player.name),
                                        subtitle: Text(player.position),
                                        trailing:
                                            Text(player.performance.toString()),
                                      ))),
                                  childWhenDragging: Opacity(
                                    opacity: 0.5,
                                    child: Card(
                                      child: ListTile(
                                        title: Text(player.name),
                                        subtitle: Text(player.position),
                                        trailing: Text(
                                          player.performance.toString(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  child: Card(
                                    child: ListTile(
                                      title: Text(player.name),
                                      subtitle: Text(player.position),
                                      trailing: Text(
                                        player.performance.toString(),
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList()),
                        ],
                      );
                    },
                  );
                },
              ).toList(),
            ),
          ],
        ),
      ),
    );
  }

  selectedItem(BuildContext context, item, Team list) {
    switch (item) {
      case 0:
        editarteams(list);
        break;
      case 1:
        eliminarteams(list);
        break;
    }
  }
}
