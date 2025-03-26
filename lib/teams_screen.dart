import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:one_futbol/database/team_dao.dart';
import 'package:one_futbol/player_screen.dart';
import 'package:one_futbol/matches.dart';
import 'package:one_futbol/player_model.dart';
import 'package:one_futbol/team_model.dart';

class Teams extends StatefulWidget {
  List<Team> teams;

  Teams({super.key, required this.teams});

  @override
  State<Teams> createState() => _TeamsState();
}

class _TeamsState extends State<Teams> {
  final daoTeam = TeamDao();

  @override
  void initState() {
    super.initState();
    updateTeams();
  }

  Future<void> updateTeams() async {
    widget.teams = await daoTeam.readAllTeam();
    setState(() {});
  }

  Future<void> eliminarteams(int index) async {
    Team team = widget.teams[index];
    await daoTeam.deleteTeam(team);
    updateTeams();
  }

  Future<void> editarteams(int index) async {
    TextEditingController nameController =
        TextEditingController(text: widget.teams[index].name);
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Editar teams[index]'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      labelText: 'Nombre del teams[index]'),
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.green)),
                  onPressed: () async {
                    widget.teams[index].name = nameController.text;
                    daoTeam.updateTeam(
                        widget.teams[index], widget.teams[index].name);
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

  selectedItem(BuildContext context, item, int index) {
    switch (item) {
      case 0:
        editarteams(index);
        break;
      case 1:
        eliminarteams(index);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 50),
            child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Teams',
                  style: GoogleFonts.aBeeZee(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                )),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: heightScreen - 200,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: widget.teams.length,
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                Team team = widget.teams[index];
                return SizedBox(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        title: Text(
                          team.name,
                          style: TextStyle(fontSize: 20),
                        ),
                        trailing: PopupMenuButton(
                          icon: Icon(
                            Icons.more_vert,
                            color: Colors.blueGrey,
                          ),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                                value: 0,
                                child: Text('Editar nombre del equipo')),
                            PopupMenuItem(
                                value: 1, child: Text('Eliminar equipo')),
                          ],
                          onSelected: (item) =>
                              selectedItem(context, item, index),
                        ),
                      ),
                      SizedBox(height: 10),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 1000),
                        // height: isExpanded
                        //     ? team.teamPlayers.length * 90
                        //     : (heightScreen * 0.25) -
                        //         (heightScreen * 0.25) % 90,
                        child: ReorderableListView.builder(
                          onReorder: (int oldIndex, int newIndex) {
                            setState(() {
                              if (newIndex > oldIndex) newIndex--;
                              final Player item = widget
                                  .teams[index].teamPlayers
                                  .removeAt(oldIndex);
                              widget.teams[index].teamPlayers
                                  .insert(newIndex, item);
                            });
                          },
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: team.teamPlayers.length,
                          itemBuilder: (context, index) {
                            return KeyedSubtree(
                              key: ValueKey(team.teamPlayers[index].id),
                              child: Card(
                                child: ListTile(
                                  title: Text(team.teamPlayers[index].name),
                                  subtitle: Text(
                                      'Posicion: ${team.teamPlayers[index].position} \nRendimiento: ${team.teamPlayers[index].performance}'),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          FloatingActionButton.extended(
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
            label: const Text('Formar partidos'),
            icon: const Icon(Icons.account_tree_rounded),
          ),
        ],
      ),
    );
  }
}

bool isExpanded = false;

// class Detalleteams[index] extends StatefulWidget {
//   Team teams[index];
//   int index;
//   Function updateTeams;

//   Detalleteams[index](
//       {super.key,
//       required this.teams[index],
//       required this.index,
//       required this.updateTeams});

//   @override
//   State<Detalleteams[index]> createState() => _DetalleTeamstate();
// }

// class _DetalleTeamstate extends State<Detalleteams[index]> {
//   final daoTeam = TeamDao();
//   bool isExpanded = false;

//   @override
//   Widget build(BuildContext context) {
//     String teamName = widget.teams[index].name;
//     double heightScreen = MediaQuery.of(context).size.height;
//     return SizedBox(
//       child: Column(
//         children: [
//           SizedBox(
//             height: 10,
//           ),
//           ListTile(
//             title: Text(
//               teamName,
//               style: TextStyle(fontSize: 20),
//             ),
//             trailing: PopupMenuButton(
//               icon: Icon(
//                 Icons.more_vert,
//                 color: Colors.blueGrey,
//               ),
//               itemBuilder: (context) => [
//                 PopupMenuItem(
//                     value: 0, child: Text('Editar nombre del teams[index]')),
//                 PopupMenuItem(value: 1, child: Text('Eliminar teams[index]')),
//               ],
//               onSelected: (item) => selectedItem(context, item),
//             ),
//           ),
//           SizedBox(height: 10),
//           AnimatedContainer(
//             duration: Duration(milliseconds: 1000),
//             height: isExpanded
//                 ? widget.teams[index].teamPlayers.length * 90
//                 : (heightScreen * 0.25) - (heightScreen * 0.25) % 90,
//             child: ReorderableListView.builder(
//               onReorder: (int oldIndex, int newIndex) {
//                 setState(() {
//                   if (newIndex > oldIndex) newIndex--;
//                   final Player item =
//                       widget.teams[index].teamPlayers.removeAt(oldIndex);
//                   widget.teams[index].teamPlayers.insert(newIndex, item);
//                 });
//               },
//               padding: EdgeInsets.zero,
//               physics: NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               itemCount: widget.teams[index].teamPlayers.length,
//               itemBuilder: (context, index) {
//                 return KeyedSubtree(
//                   key: ValueKey(widget.teams[index].teamPlayers[index].id),
//                   child: Card(
//                     child: ListTile(
//                       title: Text(widget.teams[index].teamPlayers[index].name),
//                       subtitle: Text(
//                           'Posicion: ${widget.teams[index].teamPlayers[index].position} \nRendimiento: ${widget.teams[index].teamPlayers[index].performance}'),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Visibility(
//             visible: widget.teams[index].teamPlayers.length >
//                 (((heightScreen * 0.25) - (heightScreen * 0.25) % 90) / 72),
//             child: Center(
//               child: TextButton(
//                   onPressed: () async {
//                     setState(() {
//                       isExpanded = !isExpanded;
//                     });
//                   },
//                   child: widget.teams[index].teamPlayers.length >
//                           (((heightScreen * 0.25) -
//                                   (heightScreen * 0.25) % 90) /
//                               72)
//                       ? Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             if (isExpanded)
//                               Icon(
//                                 Icons.expand_less,
//                                 color: Colors.black,
//                                 size: 25,
//                               )
//                             else
//                               Icon(
//                                 Icons.expand_more,
//                                 color: Colors.black,
//                                 size: 25,
//                               )
//                           ],
//                         )
//                       : SizedBox(height: 10)),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Future<void> eliminarteams[index]() async {
//     Team team = widget.teams[index];
//     await daoTeam.deleteTeam(team);
//     widget.updateTeams();
//   }

//   Future<void> editarteams[index]() async {
//     TextEditingController nameController =
//         TextEditingController(text: widget.teams[index].name);
//     showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Text('Editar teams[index]'),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextField(
//                   controller: nameController,
//                   decoration: InputDecoration(
//                       contentPadding: EdgeInsets.all(5),
//                       labelText: 'Nombre del teams[index]'),
//                 ),
//               ],
//             ),
//             actions: [
//               ElevatedButton(
//                   style: ButtonStyle(
//                       backgroundColor: WidgetStatePropertyAll(Colors.green)),
//                   onPressed: () async {
//                     widget.teams[index].name = nameController.text;
//                     daoTeam.updateTeam(widget.teams[index], widget.teams[index].name);
//                     widget.updateTeams();
//                     setState(() {
//                       Navigator.pop(context);
//                     });
//                   },
//                   child: Text('Guardar',
//                       style: TextStyle(
//                         color: Colors.white,
//                       ))),
//               TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: Text('Cancelar')),
//             ],
//           );
//         });
//   }

//   selectedItem(BuildContext context, item) {
//     switch (item) {
//       case 0:
//         editarteams[index]();
//         break;
//       case 1:
//         eliminarteams[index]();
//         break;
//     }
//   }
// }
