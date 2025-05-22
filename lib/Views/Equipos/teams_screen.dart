import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_futbol/Views/Equipos/matches.dart';
import 'package:one_futbol/bloc/match_bloc/match_bloc.dart';
import 'package:one_futbol/bloc/match_bloc/match_event.dart';
import 'package:one_futbol/bloc/match_bloc/match_state.dart';
import 'package:one_futbol/bloc/team_bloc/team_bloc.dart';
import 'package:one_futbol/bloc/team_bloc/team_state.dart';
import 'package:one_futbol/domain/domain.dart';

import '../../bloc/team_bloc/team_event.dart';

class Teams extends StatefulWidget {
  const Teams({super.key});

  @override
  State<Teams> createState() => _TeamsState();
}

class _TeamsState extends State<Teams> {
  late final List<Team> selectedTeams = [];

  void eliminarteams(Team list) {
    context.read<TeamBloc>().add(DeleteTeam(list));
  }

  void editarteams(Team list) {
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
                  onPressed: () {
                    list.name = nameController.text;
                    context.read<TeamBloc>().add(UpdateTeam(list));
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
        });
  }

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    final macthBloc = BlocProvider.of<MatchBloc>(context);
    return BlocBuilder<TeamBloc, TeamState>(builder: (context, state) {
      if (state is TeamLoaded) {
        final List<Team> teams = state.teams;
        if (teams.isNotEmpty) {
          return Scaffold(
              resizeToAvoidBottomInset: false,
              floatingActionButton: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20,
                children: [
                  FloatingActionButton(
                    heroTag: teams,
                    onPressed: () {
                      macthBloc.add(GenerateMatchEvent(teams));
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Matches()));
                    },
                    child: const Icon(Icons.account_tree_rounded),
                  ),
                  FloatingActionButton(
                    heroTag: teams.iterator,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Matches()));
                    },
                    child: const Icon(Icons.account_tree_outlined),
                  ),
                ],
              ),
              body: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Column(
                  children: [
                    Column(
                      children: teams.map(
                        (team) {
                          return DragTarget<Player>(
                            onAcceptWithDetails: (player) {
                              for (Team team in teams) {
                                team.teamPlayers.removeWhere(
                                  (element) => element.id == player.data.id,
                                );
                                context.read<TeamBloc>().add(UpdateTeam(team));
                              }

                              player.data.team_id = team.id;
                              team.teamPlayers.add(player.data);
                            },
                            builder: (context, candidateData, rejectedData) {
                              return Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      team.name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    trailing: PopupMenuButton(
                                      icon: Icon(
                                        Icons.more_vert,
                                        color: Colors.blueGrey,
                                      ),
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                            value: 0, child: Text('Editar')),
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
                                              constraints: BoxConstraints
                                                  .tightForFinite(),
                                              child: Card(
                                                  child: ListTile(
                                                title: Text(player.name),
                                                subtitle: Text(player.position),
                                                trailing: Text(player
                                                    .performance
                                                    .toString()),
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
                                            color: Colors.green[150],
                                            elevation: 5,
                                            shadowColor: Colors.black,
                                            child: ListTile(
                                              textColor: Colors.black,
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
              ));
        } else {
          return Center(
            child: Text('No hay equipos creados'),
          );
        }
      } else {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
    });
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

Widget ranking(BuildContext context) {
  return BlocBuilder<TeamBloc, TeamState>(builder: (context, state) {
    if (state is TeamLoaded) {
      List<Team> team = state.teams;
      team.sort(
        (a, b) => b.points.compareTo(a.points),
      );
      return ListView.builder(
        itemCount: team.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Text(
                (index + 1).toString(),
                style: TextStyle(fontSize: 15),
              ),
              title: Text(team[index].name),
              trailing: Text('Puntos ${team[index].points}',
                  style: TextStyle(fontSize: 15)),
            ),
          );
        },
      );
    } else {
      return Center(
        child: Text('Sin equipos'),
      );
    }
  });
}
