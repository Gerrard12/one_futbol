import 'dart:convert';
import 'package:one_futbol/player_model.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class Team {
  Team(
      {required this.teamPlayers,
      required this.name,
      this.id,
      required this.points});

  late int? id;
  late String name;
  late List<Player> teamPlayers;
  late double points;

  Team copyWith(
      {int? id, String? name, List<Player>? teamPlayers, double? points}) {
    return Team(
        id: id ?? this.id,
        name: name ?? this.name,
        teamPlayers: teamPlayers ?? this.teamPlayers,
        points: points ?? this.points);
  }

  factory Team.fromJson(Map<String, dynamic> map) {
    return Team(
        id: map['id'],
        name: map['name'],
        teamPlayers: (jsonDecode(map['teamPlayers']) as List)
            .map((playerMap) => Player.fromJson(playerMap))
            .toList(),
        points: map['points']);
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'teamPlayers':
          jsonEncode(teamPlayers.map((player) => player.toJson()).toList()),
      'points': points
    };
  }
}
