import 'package:flutter/material.dart';
import 'package:one_futbol/Views/Equipos/Screen_equipos.dart';

class Equipos extends StatefulWidget {
  const Equipos({super.key});

  @override
  EquiposState createState() => EquiposState();
}

GlobalKey<NavigatorState> equiposNavigatorKey = GlobalKey<NavigatorState>();

class EquiposState extends State<Equipos> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: equiposNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              return const EquiposView();
            });
      },
    );
  }
}