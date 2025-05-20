import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_futbol/bloc/player_bloc/player_event.dart';
import 'package:one_futbol/bloc/player_bloc/player_state.dart';
import 'package:one_futbol/data/Repository/player_repository.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  final PlayerRepository repository;

  PlayerBloc(this.repository) : super(PlayerLoading()) {
    on<LoadPlayer>(_onLoad);
    on<AddPlayer>(_onAdd);
    on<UpdatePlayer>(_onUpdate);
    on<DeletePlayer>(_onDelete);
  }

  Future<void> _onLoad(LoadPlayer event, Emitter<PlayerState> emit) async {
    try {
      emit(PlayerLoading());
      final players = await repository.getAllPlayers();
      emit(PlayerLoaded(players));
    } catch (e) {
      emit(PlayerError('Error al cargar jugadores'));
    }
  }

  Future<void> _onAdd(AddPlayer event, Emitter<PlayerState> emit) async {
    await repository.addPlayer(event.player);
    add(LoadPlayer());
  }

  Future<void> _onUpdate(UpdatePlayer event, Emitter<PlayerState> emit) async {
    await repository.updatePlayer(event.player);
    add(LoadPlayer());
  }

  Future<void> _onDelete(DeletePlayer event, Emitter<PlayerState> emit) async {
    await repository.detelePlayer(event.player);
    add(LoadPlayer());
  }
}
