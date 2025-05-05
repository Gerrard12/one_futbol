import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_futbol/bloc/match_bloc/match_event.dart';
import 'package:one_futbol/bloc/match_bloc/match_state.dart';
import 'package:one_futbol/data/Repository/match_repository.dart';
import 'package:one_futbol/domain/domain.dart';
import 'package:one_futbol/domain/funciones/generate_matches.dart';

class MatchBloc extends Bloc<MatchesEvent, MatchesState> {
  final MatchesRepository repository;
  final GenerateMatches generateMatch;

  MatchBloc(this.repository, this.generateMatch) : super(MatchLoading()) {
    on<LoadMatches>(_onLoad);
    on<AddMatch>(_onAdd);
    on<UpdateMatch>(_onUpdate);
    on<DeleteMatch>(_onDelete);
    on<DeleteAllMatches>(_onDeleteAll);
    on<GenerateMatchEvent>(_onGenerate);
  }

  Future<void> _onLoad(LoadMatches event, Emitter<MatchesState> emit) async {
    try {
      emit(MatchLoading());
      final matches = await repository.getAllMatches();
      emit(MatchLoaded(matches));
    } catch (e) {
      emit(MatchError('Error al cargar jugadores'));
    }
  }

  Future<void> _onAdd(AddMatch event, Emitter<MatchesState> emit) async {
    await repository.addMatch(event.match);
    add(LoadMatches());
  }

  Future<void> _onUpdate(UpdateMatch event, Emitter<MatchesState> emit) async {
    await repository.updateMatch(event.match);
    add(LoadMatches());
  }

  Future<void> _onDelete(DeleteMatch event, Emitter<MatchesState> emit) async {
    await repository.deleteMatch(event.match);
    add(LoadMatches());
  }

  Future<void> _onDeleteAll(
      DeleteAllMatches event, Emitter<MatchesState> emit) async {
    await repository.deleteAllMatches();
    add(LoadMatches());
  }

  Future<void> _onGenerate(
      GenerateMatchEvent event, Emitter<MatchesState> emit) async {
    final generated = generateMatch(event.teams);
    for (MatchModel match in generated) {
      await repository.addMatch(match);
    }

    final savedMatchs = await repository.getAllMatches();
    emit(MatchLoaded(savedMatchs));
  }
}
