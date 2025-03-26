import 'package:flutter/material.dart';
import 'package:one_futbol/database/database_helper.dart';
import 'package:one_futbol/database/player_dao.dart';
import 'package:one_futbol/player_screen.dart';
import 'package:one_futbol/player_model.dart';

class CardInfo extends StatefulWidget {
  CardInfo({
    super.key,
    this.updateList,
    required this.players,
    required this.index,
    this.goals,
  });

  final int index;
  Function? updateList;
  List<Player> players;
  double? goals;

  @override
  State<CardInfo> createState() => _CardInfoState();
}

class _CardInfoState extends State<CardInfo> {
  final dao = PlayerDao();

  Future<void> eliminarJugador() async {
    Player player = widget.players[widget.index];
    await dao.delete(player);
    widget.updateList!();
  }

  Future<void> editarJugador() async {
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
                  onPressed: () async {
                    player.name = nameController.text;
                    player.position = positionController.text;
                    player.performance =
                        double.tryParse(performanceController.text) ?? 0;
                    await dao.update(player);
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
    return Card(
      key: ValueKey(widget.players[widget.index].id),
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
