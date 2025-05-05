import 'package:one_futbol/domain/domain.dart';

abstract class TeamState {}

class TeamLoading extends TeamState {}

class TeamLoaded extends TeamState {
  final List<Team> teams;
  TeamLoaded(this.teams);
}

class TeamError extends TeamState {
  final String message;
  TeamError(this.message);
}
