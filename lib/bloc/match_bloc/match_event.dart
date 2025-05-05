import 'package:one_futbol/domain/domain.dart';

abstract class MatchesEvent {}

class LoadMatches extends MatchesEvent {}

class AddMatch extends MatchesEvent {
  final MatchModel match;
  AddMatch(this.match);
}

class UpdateMatch extends MatchesEvent {
  final MatchModel match;
  UpdateMatch(this.match);
}

class DeleteMatch extends MatchesEvent {
  final MatchModel match;
  DeleteMatch(this.match);
}

class GenerateMatchEvent extends MatchesEvent {
  final List<Team> teams;
  GenerateMatchEvent(
    this.teams,
  );
}

class DeleteAllMatches extends MatchesEvent {}

class SaveMatch extends MatchesEvent {
  final List<Team> match;
  SaveMatch(this.match);
}
