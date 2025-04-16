import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:one_futbol/bloc/drawer_event.dart';
import 'package:one_futbol/bloc/nav_drawer_bloc.dart';
import 'package:one_futbol/bloc/nav_drawer_state.dart';

class _NavigationItem {
  final NavItem item;
  final String title;
  final IconData icon;

  _NavigationItem(this.item, this.title, this.icon);
}
class NavDrawerWidget extends StatelessWidget {
  NavDrawerWidget({super.key});

  /// Drawer Items
  final List<_NavigationItem> _listItems = [
    _NavigationItem(
      NavItem.homeView,
      "Home",
      IconlyBold.home,
    ),
    _NavigationItem(
      NavItem.profileView,
      "Equipos",
      IconlyBold.profile,
    ),
    _NavigationItem(
      NavItem.orderView,
      "Historial",
      IconlyBold.category,
    ),
    _NavigationItem(
      NavItem.cartView,
      "Jugador",
      IconlyBold.bag_2,
    ),
  ];

  @override
  Widget build(BuildContext context) => Drawer(
        child: Column(
          children: [
            /// Header
            const UserAccountsDrawerHeader(
              accountName: Text(
                'Una Pichanga?',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: Text('UnaPichanga?@gmail',
                  style: TextStyle(color: Colors.white)),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://i.pinimg.com/originals/bf/b9/4e/bfb94e54c45afd24384db5ad32d71d15.gif'))),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://images3.memedroid.com/images/UPLOADED277/65815cf051c72.webp'),
              ),
            ),

            /// Items
            ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: _listItems.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) =>
                  BlocBuilder<NavDrawerBloc, NavDrawerState>(
                builder: (BuildContext context, NavDrawerState state) =>
                    _buildItem(_listItems[index], state),
              ),
            ),
          ],
        ),
      );

  /// Build Each Drawer Item
  Widget _buildItem(_NavigationItem data, NavDrawerState state) =>
      _makeListItem(data, state);

  /// Each Drawer Item
  Widget _makeListItem(_NavigationItem data, NavDrawerState state) => Card(
        color: Colors.white54,
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        borderOnForeground: true,
        elevation: 0,
        margin: EdgeInsets.zero,
        child: Builder(
          builder: (BuildContext context) => ListTile(
            title: Text(
              data.title,
              style: TextStyle(
                fontWeight: data.item == state.selectedItem
                    ? FontWeight.bold
                    : FontWeight.w300,
                color: data.item == state.selectedItem
                    ? const Color(0xFF7077F9)
                    : Colors.black,
              ),
            ),
            leading: Icon(
              data.icon,
              color: data.item == state.selectedItem
                  ? const Color(0xFF7077F9)
                  : Colors.black,
            ),
            onTap: () => _handleItemClick(context, data.item),
          ),
        ),
      );

  /// Tap OnEach item Handler
  void _handleItemClick(BuildContext context, NavItem item) {
    BlocProvider.of<NavDrawerBloc>(context).add(NavigateTo(item));
    Navigator.pop(context);
  }
}
