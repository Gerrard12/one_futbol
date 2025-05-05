import 'package:one_futbol/domain/domain.dart';

abstract class PlayerState {}

class PlayerLoading extends PlayerState {}

class PlayerLoaded extends PlayerState {
  final List<Player> players;
  PlayerLoaded(this.players);
}

class PlayerError extends PlayerState {
  final String message;
  PlayerError(this.message);
}
