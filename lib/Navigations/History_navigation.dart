import 'package:flutter/material.dart';
import 'package:one_futbol/Views/History/Screen_history.dart';

class HistoryNavigation extends StatefulWidget {
  const HistoryNavigation({super.key});

  @override
  HistoryNavigationState createState() => HistoryNavigationState();
}

GlobalKey<NavigatorState> historyNavigatorKey = GlobalKey<NavigatorState>();

class HistoryNavigationState extends State<HistoryNavigation> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: historyNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            return const DatosCarta();
          },
        );
      },
    );
  }
}