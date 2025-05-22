import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_futbol/Views/Equipos/teams_screen.dart';
import 'package:one_futbol/bloc/match_bloc/match_bloc.dart';
import 'package:one_futbol/bloc/match_bloc/match_event.dart';
import 'package:one_futbol/bloc/match_bloc/match_state.dart';

import 'package:one_futbol/Views/Equipos/match_details.dart';
import 'package:one_futbol/bloc/team_bloc/team_bloc.dart';
import 'package:one_futbol/bloc/team_bloc/team_event.dart';
import 'package:one_futbol/domain/entities/match_model.dart';
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
              onPressed: () {
                context.read<MatchBloc>().add(DeleteAllMatches());
                deleteTeamGoals(matches, context);
                deleteTeamPoints(matches, context);
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
                ranking(),
                SingleChildScrollView(
                    child: Column(children: [Marcador(matches: matches)])),
              ],
            ));
      } else {
        return Scaffold(body: Center(child: CircularProgressIndicator()));
      }
    });
  }
}

Widget createMatch(List<MatchModel> matches, context) {
  double widthScreen = MediaQuery.of(context).size.width;
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
                      matches: matches,
                      index: index,
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
}

void deleteTeamGoals(List<MatchModel> matches, BuildContext context) {
  for (MatchModel match in matches) {
    for (int i = 0; i < matches.length; i++) {
      match.teams[i].teamGoals = 0;
      context.read<TeamBloc>().add(UpdateTeam(match.teams[i]));
    }
  }
}

void deleteTeamPoints(List<MatchModel> matches, BuildContext context) {
  for (MatchModel match in matches) {
    for (int i = 0; i < matches.length; i++) {
      match.teams[i].points = 0;
      context.read<TeamBloc>().add(UpdateTeam(match.teams[i]));
    }
  }
}
