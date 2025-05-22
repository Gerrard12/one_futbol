import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_futbol/bloc/nav_drawer_bloc/drawer_event.dart';
import 'package:one_futbol/bloc/nav_drawer_bloc/nav_drawer_bloc.dart';
import 'package:one_futbol/bloc/nav_drawer_bloc/nav_drawer_state.dart';

import 'package:one_futbol/bloc/player_bloc/player_bloc.dart';
import 'package:one_futbol/bloc/player_bloc/player_event.dart';
import 'package:one_futbol/bloc/player_bloc/player_state.dart';

import 'package:one_futbol/Views/Player/player_info.dart';
import 'package:one_futbol/bloc/team_bloc/team_bloc.dart';
import 'package:one_futbol/bloc/team_bloc/team_event.dart';

import 'package:one_futbol/domain/domain.dart';

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

  HashSet<Player> selectedItem = HashSet();
  bool isMultiSelectionEnable = false;
  List<Player> selectedPlayers = [];

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
      body: Builder(builder: (context) {
        final teamB = BlocProvider.of<TeamBloc>(context);
        double height = MediaQuery.of(context).size.height;

        return BlocBuilder<PlayerBloc, PlayerState>(builder: (context, state) {
          if (state is PlayerLoaded) {
            List<Player> players = state.players;
            return Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      getSelectedItemCount(players),
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
                            icon: Icon(Icons.group_add))),
                    Visibility(
                      visible: players.isNotEmpty,
                      child: IconButton(
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
                    ),
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
                        onPressed: () async {
                          await formarEquipos(teamB);
                          context
                              .read<NavDrawerBloc>()
                              .add(NavigateTo(NavItem.profileView));
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: height - height / 2.96,
                  child: ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.all(8),
                    itemCount: players.length,
                    itemBuilder: (BuildContext context, int index) {
                      Player player = players[index];
                      return player.status == 'Activo'
                          ? InkWell(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              onTap: () {
                                multiSelection(players[index]);
                              },
                              onLongPress: () {
                                isMultiSelectionEnable = true;
                                multiSelection(players[index]);
                              },
                              child: CardInfo(
                                player: player,
                                selectedPlayer: selectedItem,
                              ),
                            )
                          : CardInfo(
                              player: player,
                              selectedPlayer: selectedItem,
                            );
                    },
                  ),
                ),
              ],
            );
          }
          return Center(
            child: FloatingActionButton.small(
              heroTag: 2,
              child: Icon(Icons.person_add_alt_1),
              onPressed: () {
                setState(() {
                  agregarJugador();
                });
              },
            ),
          );
        });
      }),
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

  String getSelectedItemCount(List<Player> players) {
    if (players.isEmpty) {
      return 'Agrega jugadores';
    } else {
      return selectedItem.isNotEmpty
          ? "${selectedItem.length} jugadores seleccionados"
          : 'Selecciona jugadores';
    }
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
                        goals: 0,
                        status: 'Activo');

                    nombreC.clear();
                    rendimientoC.clear();
                    posicionC.clear();

                    if (nombre.isNotEmpty && posicion.isNotEmpty) {
                      if (rendimiento > 0 && rendimiento <= 10) {
                        context.read<PlayerBloc>().add(AddPlayer(player));
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

  Future<void> formarEquipos(TeamBloc teamBloc) async {
    List list = ['Aleatorio', 'Balanceado'];
    final List<MenuEntry> menuEntries = UnmodifiableListView<MenuEntry>(
        list.map<MenuEntry>((name) => MenuEntry(
            value: name,
            label: name,
            style: ButtonStyle(alignment: Alignment.centerLeft))));
    String dropdownValue = list.first;

    TextEditingController numEquipos = TextEditingController();
    TextEditingController numPlayers = TextEditingController();

    await showDialog(
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
                              onPressed: () => Navigator.pop(context),
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    } else {
                      teamBloc.add(GenerateTeamEvent(selectedPlayers, num,
                          numPlayer, dropdownValue.toLowerCase()));
                      Navigator.pop(context);
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
