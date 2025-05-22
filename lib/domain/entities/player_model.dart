class Player {
  Player(
      {required this.performance,
      required this.name,
      required this.position,
      required this.goals,
      required this.status,
      this.team_id,
      this.id});

  late int? id;
  late double performance;
  late String name;
  late String position;
  late int? team_id;
  late int goals;
  late String status;

  Player copyWith(
      {int? id,
      String? name,
      double? performance,
      String? position,
      int? goals,
      String? status,
      int? team_id}) {
    return Player(
        id: id ?? this.id,
        performance: performance ?? this.performance,
        name: name ?? this.name,
        position: position ?? this.position,
        goals: goals ?? this.goals,
        status: status ?? this.status,
        team_id: team_id ?? this.team_id);
  }

  factory Player.fromJson(Map<String, dynamic> map) {
    return Player(
        id: map['id'],
        performance: map['performance'],
        name: map['name'],
        position: map['position'],
        goals: map['goals'],
        status: map['status'],
        team_id: map['team_id']);
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'performance': performance,
      'position': position,
      'goals': goals,
      'status': status,
      'team_id': team_id,
    };
  }
}
