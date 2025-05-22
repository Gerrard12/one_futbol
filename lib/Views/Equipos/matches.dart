import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_futbol/Views/Equipos/teams_screen.dart';
import 'package:one_futbol/bloc/match_bloc/match_bloc.dart';
import 'package:one_futbol/bloc/match_bloc/match_event.dart';
import 'package:one_futbol/bloc/match_bloc/match_state.dart';

import 'package:one_futbol/Views/Equipos/match_details.dart';
import 'package:one_futbol/bloc/team_bloc/team_bloc.dart';
import 'package:one_futbol/bloc/team_bloc/team_event.dart';
import 'package:one_futbol/bloc/team_bloc/team_state.dart';
import 'package:one_futbol/domain/domain.dart';
import 'package:one_futbol/widget/Score_board_widget.dart';

class Matches extends StatefulWidget {
  const Matches({super.key});

  @override
  State<Matches> createState() => _MatchesState();
}

class _MatchesState extends State<Matches> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatchBloc, MatchesState>(builder: (context, state) {
      if (state is MatchLoaded) {
        final List<MatchModel> matches = state.matches;

        return Scaffold(
            floatingActionButton: FloatingActionButton.small(
              heroTag: 3 * 3,
              onPressed: () {
                context.read<MatchBloc>().add(DeleteAllMatches());
                deleteTeamGoals(matches, context);
                deleteTeamPoints(matches, context);
                reiniciarBracketCount();
              },
              child: Icon(Icons.delete_forever),
            ),
            appBar: AppBar(
              title: const Text('Partidos'),
              bottom: TabBar(
                controller: _tabController,
                tabs: const <Widget>[
                  Tab(
                    text: 'Matches',
                  ),
                  Tab(
                    text: 'Ranking',
                  ),
                  Tab(
                    text: 'Historial',
                  ),
                ],
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children: <Widget>[
                createMatch(matches, context),
                ranking(context),
                SingleChildScrollView(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: matches.length,
                        itemBuilder: (context, index) {
                          return Marcador(match: matches[index]);
                        })),
              ],
            ));
      } else {
        return Scaffold(body: Center(child: CircularProgressIndicator()));
      }
    });
  }
}

Widget createMatch(List<MatchModel> matches, BuildContext context) {
  double widthScreen = MediaQuery.of(context).size.width;
  List<Team> teams = [];

  return BlocBuilder<TeamBloc, TeamState>(builder: (context, state) {
    if (state is TeamLoaded) {
      teams = state.teams;
    }
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: matches.length,
      itemBuilder: (BuildContext context, int index) {
        MatchModel m = matches[index];
        return InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MatchDetails(
                        match: m,
                      ))),
          child: Card(
            child: Row(children: [
              Container(
                  width: (widthScreen / 2) - 20,
                  alignment: Alignment.topRight,
                  child: ListTile(
                    title: Text(
                      m.teams[0].name,
                      style: TextStyle(fontSize: 20),
                    ),
                    trailing: Image.asset(
                      'assets/image/real.png',
                      width: 60,
                      height: 60,
                    ),
                  )),
              Container(
                alignment: Alignment.center,
                child: Text('VS'),
              ),
              Container(
                  width: (widthScreen / 2) - 20,
                  alignment: Alignment.topLeft,
                  child: ListTile(
                    leading: Image.asset(
                      'assets/image/Barca.png',
                      width: 60,
                      height: 60,
                    ),
                    title: Text(
                      m.teams[1].name,
                      style: TextStyle(fontSize: 20),
                    ),
                  )),
            ]),
          ),
        );
      },
    );
  });
}

void deleteTeamGoals(List<MatchModel> matches, BuildContext context) {
  TeamState state = context.read<TeamBloc>().state;
  if (state is TeamLoaded) {
    List<Team> teams = state.teams;
    for (int i = 0; i < teams.length; i++) {
      teams[i].teamGoals = 0;
      context.read<TeamBloc>().add(UpdateTeam(teams[i]));
    }
  }
}

void deleteTeamPoints(List<MatchModel> matches, BuildContext context) {
  TeamState state = context.read<TeamBloc>().state;
  if (state is TeamLoaded) {
    List<Team> teams = state.teams;
    for (int i = 0; i < teams.length; i++) {
      teams[i].points = 0;
      context.read<TeamBloc>().add(UpdateTeam(teams[i]));
    }
  }
}

void reiniciarBracketCount() {
  bracketCount = 1;
}

void createNewMatches(MatchModel match, BuildContext context) {
  late List<Team> filteredTeams = [];
  TeamState state = context.read<TeamBloc>().state;
  MatchesState matchesState = context.read<MatchBloc>().state;
  if (state is TeamLoaded && matchesState is MatchLoaded) {
    List<Team> teams = state.teams;
    List<MatchModel> matches = matchesState.matches;
    if (bracketCount < teams.length) {
      if (teams.length.isOdd) {
        filteredTeams.addAll(teams);
        // for (Team team in match.teams) {
        //   filteredTeams.removeWhere((Team t) => t.name == team.name);
        // }
        for (MatchModel m in matches) {
          filteredTeams.where((t) => m.teams.contains(t));
        }
        List<Team> selectedTeams = [...filteredTeams, ...winnerTeams];
        log(selectedTeams.toString());
        if (selectedTeams.length >= 2) {
          BlocProvider.of<MatchBloc>(context)
              .add(GenerateMatchEvent(selectedTeams));
          bracketCount++;
        }
      } else if (winnerTeams.length == 2) {
        List<Team> selectedTeams = [...filteredTeams, ...winnerTeams];
        if (selectedTeams.length >= 2) {
          BlocProvider.of<MatchBloc>(context)
              .add(GenerateMatchEvent(selectedTeams));
          bracketCount++;
        }
      } else if (winnerTeams.length > 2) {
        winnerTeams.clear();
      }
    } else {
      return;
    }
  }
}
