import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:one_futbol/database/player_dao.dart';
import 'package:one_futbol/database/team_dao.dart';
import 'package:one_futbol/Views/Player/player_info.dart';
import 'package:one_futbol/models/player_model.dart';
import 'package:one_futbol/models/team_model.dart';
import 'package:one_futbol/Views/Equipos/teams_screen.dart';

class Players extends StatefulWidget {
  const Players({super.key});
  @override
  State<Players> createState() => _PlayersState();
}

typedef MenuEntry = DropdownMenuEntry<String>;
List<Player> players = [];
List<Team> teams = [];

class _PlayersState extends State<Players> {
  TextEditingController nombreC = TextEditingController();
  TextEditingController posicionC = TextEditingController();
  TextEditingController rendimientoC = TextEditingController();

  final dao = PlayerDao();
  final daoTeam = TeamDao();
  late int teamNumber = 0;
  HashSet<Player> selectedItem = HashSet();
  bool isMultiSelectionEnable = false;
  List<Player> selectedPlayers = [];

  @override
  void initState() {
    super.initState();
    updatePlayers();
  }

  Future<void> updatePlayers() async {
    players = await dao.readAll();
    teams = await daoTeam.readAllTeam();
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
        titleTextStyle: TextStyle(color: Colors.black87, fontSize: 22),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                getSelectedItemCount(),
              ),
              Visibility(
                  visible: selectedItem.isNotEmpty,
                  child: IconButton(
                      onPressed: () {
                        for (var element in selectedItem) {
                          selectedPlayers.add(element);
                        }
                        selectedItem.clear();
                        setState(() {});
                      },
                      icon: Icon(Icons.checklist_rtl_sharp))),
              IconButton(
                  onPressed: () {
                    if (selectedItem.length == players.length) {
                      selectedItem.clear();
                    } else {
                      for (int i = 0; i < players.length; i++) {
                        selectedItem.add(players[i]);
                      }
                    }
                    setState(() {});
                  },
                  icon: Icon(Icons.add_task_outlined)),
              FloatingActionButton.small(
                heroTag: 2,
                child: Icon(Icons.person_add_alt_1),
                onPressed: () {
                  setState(() {
                    agregarJugador();
                  });
                },
              ),
              Visibility(
                visible: selectedPlayers.isNotEmpty,
                child: FloatingActionButton.small(
                  heroTag: 3,
                  child: Icon(Icons.group_add_outlined),
                  onPressed: () {
                    formarEquipos(teams);
                  },
                ),
              ),
              Visibility(
                visible: teams.isNotEmpty,
                child: FloatingActionButton.small(
                  heroTag: 4,
                  foregroundColor: Colors.green,
                  child: Icon(Icons.group),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Teams(
                                  teams: teams,
                                ))).then(
                      (_) => updatePlayers(),
                    );
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.all(8),
              itemCount: players.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    multiSelection(players[index]);
                  },
                  onLongPress: () {
                    isMultiSelectionEnable = true;
                    multiSelection(players[index]);
                  },
                  child: CardInfo(
                    index: index,
                    players: players,
                    selectedPlayer: selectedItem,
                    updateList: updatePlayers,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void multiSelection(Player player) {
    if (selectedItem.contains(player)) {
      selectedItem.remove(player);
    } else {
      selectedItem.add(player);
    }
    setState(() {});
  }

  String getSelectedItemCount() {
    return selectedItem.isNotEmpty
        ? "${selectedItem.length} jugadores seleccionados"
        : 'Selecciona jugadores';
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
                        position: posicion,
                        goals: 0);

                    nombreC.clear();
                    rendimientoC.clear();
                    posicionC.clear();

                    if (nombre.isNotEmpty && posicion.isNotEmpty) {
                      if (rendimiento > 0 && rendimiento <= 10) {
                        final id = await dao.insert(player);
                        player = player.copyWith(id: id);
                        players.add(player);
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

  Future<void> genrateTeam(int count, int playerLength, String type) async {
    List<Player> sortedPlayers = List.from(selectedPlayers)
      ..sort(
        (a, b) => b.performance.compareTo(a.performance),
      );

    List<List<Player>> auxTeams = List.generate(
      count,
      (_) => [],
    );
    int start = 0;
    int end = sortedPlayers.length - 1;
    int teamIndex = 0;

    if (type == 'balanceado') {
      while (start <= end &&
          auxTeams.any(
            (element) => element.length < playerLength,
          )) {
        if (start != end && auxTeams[teamIndex].length + 2 <= playerLength) {
          auxTeams[teamIndex]
              .addAll([sortedPlayers[start], sortedPlayers[end]]);
          start++;
          end--;
        } else if (auxTeams[teamIndex].length < playerLength) {
          auxTeams[teamIndex].add(sortedPlayers[start]);
          start++;
        }
        teamIndex = (teamIndex + 1) % count;
      }
    } else {
      sortedPlayers.shuffle();
      for (int i = 0; i < end + 1; i++) {
        auxTeams[i % count].add(sortedPlayers[i]);
      }
    }
    for (int i = 0; i < auxTeams.length; i++) {
      bool arquero = auxTeams[i].any(
        (element) => element.position.toLowerCase() == 'arquero',
      );
      if (!arquero && auxTeams[i].isNotEmpty) {
        auxTeams[i][0].position = 'Arquero';
      }
    }
    for (int i = 0; i < auxTeams.length; i++) {
      List<Player> list = auxTeams[i];

      selectedPlayers = auxTeams[i];

      for (Player player in list) {
        player.team_id = i + 1;
      }

      Team team = Team(
          name: 'Equipo ${i + 1}',
          teamPlayers: selectedPlayers,
          points: 0,
          teamGoals: 0);

      final id = await daoTeam.insertTeam(team);
      team = team.copyWith(id: id);
      teams.add(team);
    }
    selectedPlayers.clear();
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Teams(
                  teams: teams,
                ))).then(
      (_) => updatePlayers(),
    );
  }

  void formarEquipos(List<Team> teams) {
    List list = ['Aleatorio', 'Balanceado'];
    final List<MenuEntry> menuEntries = UnmodifiableListView<MenuEntry>(
        list.map<MenuEntry>((name) => MenuEntry(
            value: name,
            label: name,
            style: ButtonStyle(alignment: Alignment.centerLeft))));
    String dropdownValue = list.first;

    TextEditingController numEquipos = TextEditingController();
    TextEditingController numPlayers = TextEditingController();

    showDialog(
        useSafeArea: true,
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
                TextField(
                  controller: numPlayers,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      labelText: 'Número de Jugadores'),
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
                  onPressed: () {
                    int num = int.tryParse(numEquipos.text) ?? 0;
                    int numPlayer = int.tryParse(numPlayers.text) ?? 0;
                    if (selectedPlayers.length < num * numPlayer) {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Insucientes jugadores'),
                          content: Text(
                              'No hay suficientes jugadores seleccionados para formar los equipos'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(context, 'Cancelar'),
                              child: Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    } else {
                      setState(() {
                        genrateTeam(
                            num, numPlayer, dropdownValue.toLowerCase());
                      });
                    }
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
