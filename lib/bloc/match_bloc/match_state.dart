import 'package:one_futbol/domain/domain.dart';

abstract class MatchesState {}

class MatchLoading extends MatchesState {}

class MatchLoaded extends MatchesState {
  final List<MatchModel> matches;
  MatchLoaded(this.matches);
}

class MatchError extends MatchesState {
  final String message;
  MatchError(this.message);
}
