import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:one_futbol/database/player_dao.dart';
import 'package:one_futbol/database/team_dao.dart';
import 'package:one_futbol/player_info.dart';
import 'package:one_futbol/player_model.dart';
import 'package:one_futbol/team_model.dart';
import 'package:one_futbol/teams_screen.dart';

class Players extends StatefulWidget {
  const Players({super.key});
  @override
  State<Players> createState() => _PlayersState();
}

typedef MenuEntry = DropdownMenuEntry<String>;

class _PlayersState extends State<Players> {
  TextEditingController nombreC = TextEditingController();
  TextEditingController posicionC = TextEditingController();
  TextEditingController rendimientoC = TextEditingController();

  List<Player> players = [];
  List<Team> teams = [];
  final dao = PlayerDao();
  final daoTeam = TeamDao();
  late int teamNumber = 0;

  @override
  void initState() {
    super.initState();
    updatePlayers();
  }

  Future<void> updatePlayers() async {
    players = await dao.readAll();
    setState(() {});
  }

  @override
  void dispose() {
    nombreC.dispose();
    posicionC.dispose();
    rendimientoC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Players',
            style: GoogleFonts.aBeeZee(),
          ),
          titleTextStyle: TextStyle(color: Colors.black87, fontSize: 22)),
      body: Column(children: [
        ReorderableListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          itemCount: players.length,
          itemBuilder: (BuildContext context, int index) {
            return KeyedSubtree(
              key: ValueKey(players[index].id),
              child: CardInfo(
                index: index,
                players: players,
                updateList: updatePlayers,
              ),
            );
          },
          onReorder: (int oldIndex, int newIndex) {
            setState(() {
              if (newIndex > oldIndex) newIndex--;
              final Player item = players.removeAt(oldIndex);
              players.insert(newIndex, item);
            });
          },
        ),
        SizedBox(height: 20),
        FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 7,
            children: [
              FloatingActionButton.extended(
                heroTag: 2,
                onPressed: () {
                  setState(() {
                    agregarJugador();
                  });
                },
                label: const Text('Añadir Jugador'),
                icon: const Icon(Icons.add),
              ),
              FloatingActionButton.extended(
                heroTag: 3,
                onPressed: () {
                  formarEquipos(teamNumber);
                },
                label: const Text('Formar equipos'),
                icon: const Icon(Icons.align_horizontal_right_sharp),
              ),
              FloatingActionButton.extended(
                heroTag: 4,
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Teams(
                                teams: teams,
                              )));
                },
                label: const Text('Mis equipos'),
                icon: const Icon(Icons.align_horizontal_right_sharp),
              ),
              SizedBox(height: 50)
            ],
          ),
        ),
      ]),
    );
  }

  void agregarJugador() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20),
              Text(
                'Nuevo Jugador',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              TextField(
                controller: nombreC,
                decoration: InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: posicionC,
                decoration: InputDecoration(labelText: 'Posicion'),
              ),
              TextField(
                controller: rendimientoC,
                decoration: InputDecoration(labelText: 'Rendimiento'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.green)),
                  onPressed: () async {
                    String nombre = nombreC.text;
                    double rendimiento =
                        double.tryParse(rendimientoC.text) ?? 0;
                    String posicion = posicionC.text;

                    Player player = Player(
                        performance: rendimiento,
                        name: nombre,
                        position: posicion);

                    nombreC.clear();
                    rendimientoC.clear();
                    posicionC.clear();

                    if (nombre.isNotEmpty && posicion.isNotEmpty) {
                      if (rendimiento > 0 && rendimiento <= 10) {
                        final id = await dao.insert(player);
                        player = player.copyWith(id: id);
                        players.add(player);
                        print('Playerid: ${player.id}');
                      }
                      setState(() {
                        Navigator.pop(context);
                      });
                    }
                  },
                  child: Text(
                    'Guardar',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )),
              SizedBox(height: 20)
            ],
          ),
        );
      },
    );
  }

  void formarEquipos(int count) {
    List list = ['Aleatorio', 'Balanceado'];
    final List<MenuEntry> menuEntries = UnmodifiableListView<MenuEntry>(
        list.map<MenuEntry>((name) => MenuEntry(
            value: name,
            label: name,
            style: ButtonStyle(alignment: Alignment.centerLeft))));
    String dropdownValue = list.first;

    TextEditingController numEquipos = TextEditingController();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Configurar equipos'),
            actions: [
              Column(children: [
                TextField(
                  controller: numEquipos,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      labelText: 'Número de equipos'),
                ),
                SizedBox(height: 30),
                DropdownMenu<String>(
                  expandedInsets: EdgeInsets.only(right: 60),
                  label: Text('Formación de equipos'),
                  initialSelection: list.first,
                  onSelected: (String? value) {
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                  dropdownMenuEntries: menuEntries,
                ),
                SizedBox(height: 20),
              ]),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.green)),
                  onPressed: () async {
                    int num = int.tryParse(numEquipos.text) ?? 0;
                    teamNumber = num;
                    count = num;
                    List<List<Player>> equipos =
                        List.generate(count, (index) => []);
                    List<double> teamScore = List.filled(count, 0);
                    if (dropdownValue == 'Balanceado') {
                      players.sort(
                        (a, b) => b.performance.compareTo(a.performance),
                      );
                      for (var player in players) {
                        int minIndex = teamScore
                            .indexOf(teamScore.reduce((a, b) => a < b ? a : b));
                        equipos[minIndex].add(player);

                        teamScore[minIndex] += player.performance;
                      }
                      // for (int i = 0; i < players.length; i++) {
                      //   equipos[i % count].add(players[i]);
                      //   setState(() {
                      //     players[i].performance++;
                      //   });
                      // }
                    } else {
                      players.shuffle();

                      for (int i = 0; i < players.length; i++) {
                        equipos[i % count].add(players[i]);
                      }
                      for (int i = 0; i < equipos.length; i++) {
                        Team team = Team(
                            name: 'Equipo ${i + 1}',
                            teamPlayers: equipos[i],
                            points: 0);
                        final id = await daoTeam.insertTeam(team);
                        team = team.copyWith(id: id);
                        teams.add(team);
                      }
                    }
                    Navigator.pop(context);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Teams(
                                  teams: teams,
                                )));
                  },
                  child: Text(
                    'Guardar',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          );
        });
  }
}
