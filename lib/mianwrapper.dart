import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:one_futbol/Views/Equipos/teams_screen.dart';
import 'package:one_futbol/Views/Player/player_screen.dart';
import 'package:one_futbol/bloc/nav_drawer_bloc/nav_drawer_bloc.dart';
import 'package:one_futbol/bloc/nav_drawer_bloc/nav_drawer_state.dart';
import 'package:one_futbol/view/home_view.dart';
import 'package:one_futbol/view/historial_view.dart';
import 'package:one_futbol/view/setting_view.dart';
import 'package:one_futbol/widget/drawer_widget.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  MainWrapperState createState() => MainWrapperState();
}

class MainWrapperState extends State<MainWrapper> {
  late NavDrawerBloc _bloc;
  late Widget _content;

  @override
  void initState() {
    super.initState();
    _bloc = NavDrawerBloc();
    _content = _getContentForState(_bloc.state.selectedItem);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavDrawerBloc>(
      create: (BuildContext context) => _bloc,
      child: BlocConsumer<NavDrawerBloc, NavDrawerState>(
        listener: (BuildContext context, NavDrawerState state) {
          _content = _getContentForState(state.selectedItem);
        },
        buildWhen: (previous, current) {
          return previous.selectedItem != current.selectedItem;
        },
        listenWhen: (previous, current) {
          return previous.selectedItem != current.selectedItem;
        },
        builder: (BuildContext context, NavDrawerState state) {
          return Scaffold(
            drawer: NavDrawerWidget(),
            appBar: _buildAppBar(state),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (_) => const SettingView()));
              },
              child: const Icon(IconlyBold.setting),
            ),
            body: AnimatedSwitcher(
              switchInCurve: Curves.easeInExpo,
              switchOutCurve: Curves.easeOutExpo,
              duration: const Duration(milliseconds: 400),
              child: _content,
            ),
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(NavDrawerState state) {
    return AppBar(
      iconTheme: const IconThemeData(),
      title: Text(
        _getAppBarTitle(state.selectedItem),
        style: const TextStyle(),
      ),
      centerTitle: false,
      backgroundColor: const Color(0xFF7077F9),
    );
  }

  Widget _getContentForState(NavItem selectedItem) {
    switch (selectedItem) {
      case NavItem.homeView:
        return const HomeView();
      case NavItem.profileView:
        return const Teams();
      case NavItem.orderView:
        return const HistorialView();
      case NavItem.cartView:
        return const Players();
      // ignore: unreachable_switch_default
      default:
        return Container();
    }
  }

  String _getAppBarTitle(NavItem selectedItem) {
    switch (selectedItem) {
      case NavItem.homeView:
        return "Home";
      case NavItem.profileView:
        return "Equipos";
      case NavItem.orderView:
        return "Historial";
      case NavItem.cartView:
        return "Jugador";
      // ignore: unreachable_switch_default
      default:
        return "Navigation Drawer Demo";
    }
  }
}
