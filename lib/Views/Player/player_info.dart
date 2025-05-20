import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_futbol/bloc/player_bloc/player_bloc.dart';
import 'package:one_futbol/bloc/player_bloc/player_event.dart';
import 'package:one_futbol/domain/entities/player_model.dart';

class CardInfo extends StatefulWidget {
  const CardInfo({
    super.key,
    required this.players,
    required this.index,
    required this.selectedPlayer,
  });

  final int index;
  final HashSet<Player> selectedPlayer;
  final List<Player> players;

  @override
  State<CardInfo> createState() => _CardInfoState();
}

class _CardInfoState extends State<CardInfo> {
  void eliminarJugador() {
    Player player = widget.players[widget.index];
    widget.selectedPlayer.remove(player);
    context.read<PlayerBloc>().add(DeletePlayer(player));
  }

  void editarJugador() {
    Player player = widget.players[widget.index];
    TextEditingController nameController =
        TextEditingController(text: player.name);
    TextEditingController positionController =
        TextEditingController(text: player.position);
    TextEditingController performanceController =
        TextEditingController(text: player.performance.toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Editar jugador'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(5), labelText: 'Nombre'),
              ),
              TextField(
                controller: positionController,
                decoration: InputDecoration(labelText: 'Posicion'),
              ),
              TextField(
                controller: performanceController,
                decoration: InputDecoration(labelText: 'Rendimiento'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.green)),
                onPressed: () {
                  player.name = nameController.text;
                  player.position = positionController.text;
                  player.performance =
                      double.tryParse(performanceController.text) ?? 0;
                  context.read<PlayerBloc>().add(UpdatePlayer(player));
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: Colors.black,
      child: ListTile(
        title: Text(
          widget.players[widget.index].name,
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        subtitle: Text(widget.players[widget.index].position,
            style: TextStyle(color: Colors.black)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              widget.players[widget.index].performance.toString(),
              style: TextStyle(
                  color: widget.players[widget.index].performance >= 5
                      ? Colors.green
                      : Colors.orange,
                  fontSize: 20),
            ),
            PopupMenuButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.blueGrey,
              ),
              itemBuilder: (context) => [
                PopupMenuItem(value: 0, child: Text('Editar')),
                PopupMenuItem(value: 1, child: Text('Eliminar')),
              ],
              onSelected: (item) => selectedItem(context, item),
            ),
            Visibility(
              visible:
                  widget.selectedPlayer.contains(widget.players[widget.index]),
              child: Icon(
                Icons.check_circle_outline,
                size: 30,
                color: Colors.green,
              ),
            )
          ],
        ),
      ),
    );
  }

  selectedItem(BuildContext context, item) {
    switch (item) {
      case 0:
        editarJugador();
        break;
      case 1:
        eliminarJugador();
        break;
    }
  }
}
