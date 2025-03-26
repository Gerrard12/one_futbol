
import 'package:flutter/material.dart';
import 'package:one_futbol/database/team_dao.dart';
import 'package:one_futbol/match_details.dart';
import 'package:one_futbol/team_model.dart';

// ignore: must_be_immutable
class Matches extends StatefulWidget {
  Matches({super.key, required this.team});
  List<Team> team;

  @override
  State<Matches> createState() => _MatchesState();
}

class _MatchesState extends State<Matches> with TickerProviderStateMixin {
  late final TabController _tabController;
  final dao = TeamDao();

  @override
  void initState() {
    super.initState();
    updateTeams();
    _tabController = TabController(length: 3, vsync: this);
  }
  

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> updateTeams() async {
    widget.team = await dao.readAllTeam();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          createMatch(widget.team, context),
          ranking(widget.team),
          Center(child: Text("Partidos")),
        ],
      ),
    );
  }
}

Widget createMatch(List<Team> team, context) {
  double widthScreen = MediaQuery.of(context).size.width;
  int count = (team.length / 2).toInt();
  List<List<Team>> match = List.generate(count, (index) => []);
  team.shuffle();
  for (int i = 0; i < team.length; i++) {
    match[i % count].add(team[i]);
  }

  return ListView.builder(
    padding: EdgeInsets.zero,
    itemCount: match.length,
    itemBuilder: (BuildContext context, int index) {
      print('MATCHES HECHOS ${match[index]}');
      List<Team> m = match[index];
      return InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MatchDetails(
                      teams: team,
                      match: match,
                      index: index,
                    ))),
        child: Card(
          child: Row(children: [
            Container(
                width: (widthScreen / 2) - 20,
                alignment: Alignment.topRight,
                child: ListTile(
                  title: Text(
                    m[0].name,
                    style: TextStyle(fontSize: 20),
                  ),
                  trailing: Image.asset(
                    'assets/rm_logo.png',
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
                    'assets/barca_logo.png',
                    width: 60,
                    height: 60,
                  ),
                  title: Text(
                    m[1].name,
                    style: TextStyle(fontSize: 20),
                  ),
                )),
          ]),
        ),
      );
    },
  );
}

Widget ranking(List<Team> team) {
  team.sort(
    (a, b) => b.points.compareTo(a.points),
  );

  return ListView.builder(
    itemCount: team.length,
    itemBuilder: (context, index) {
      return Card(
        child: ListTile(
          leading: Text(
            (index + 1).toString(),
            style: TextStyle(fontSize: 15),
          ),
          title: Text(team[index].name),
          trailing: Text('Puntos ${team[index].points}',
              style: TextStyle(fontSize: 15)),
        ),
      );
    },
  );
}
