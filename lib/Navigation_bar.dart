import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:one_futbol/Navigations/Equipos_navigation.dart';
import 'package:one_futbol/Navigations/History_navigation.dart';
import 'package:one_futbol/Navigations/Home_navigation.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  MainWrapperState createState() => MainWrapperState();
}

class MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    homeNavigatorKey,
    historyNavigatorKey,
    equiposNavigatorKey
  ];

  Future<bool> _systemBackButtonPressed() async {
    if (_navigatorKeys[_selectedIndex].currentState?.canPop() == true) {
      _navigatorKeys[_selectedIndex]
          .currentState
          ?.pop(_navigatorKeys[_selectedIndex].currentContext);
      return false;
    } else {
      SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
      return true; // Indicate that the back action is handled
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _systemBackButtonPressed,
      child: Scaffold(
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          selectedIndex: _selectedIndex,
          destinations: const [
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.sports_soccer),
              icon: Icon(Icons.sports_soccer),
              label: 'Equipos',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.history_outlined),
              icon: Icon(Icons.history),
              label: 'History',
            ),
            
          ],
        ),
        body: SafeArea(
          top: false,
          child: IndexedStack(
            index: _selectedIndex,
            children: const <Widget>[
              Home(),
              Equipos(),
              HistoryNavigation(),
            ],
          ),
        ),
      ),
    );
  }
}