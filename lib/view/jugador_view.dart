import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:one_futbol/bloc/nav_drawer_bloc/drawer_event.dart';
import 'package:one_futbol/bloc/nav_drawer_bloc/nav_drawer_bloc.dart';
import 'package:one_futbol/bloc/nav_drawer_bloc/nav_drawer_state.dart';

class JugadorView extends StatelessWidget {
  const JugadorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              IconlyBold.bag_2,
              size: 100,
            ),
            const Text(
              "Judador View",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                "It can be a stateless or stateful class. You can place any content or widgets you need within this page class.",
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CupertinoButton(
                color: const Color(0xFFAC0202),
                child: const Text("View All Orders"),
                onPressed: () {
                  BlocProvider.of<NavDrawerBloc>(context)
                      .add(const NavigateTo(NavItem.orderView));
                }),
            TextButton(
                onPressed: () {
                  BlocProvider.of<NavDrawerBloc>(context)
                      .add(const NavigateTo(NavItem.homeView));
                },
                child: const Text("Back To Home")),
          ],
        ),
      ),
    );
  }
}
