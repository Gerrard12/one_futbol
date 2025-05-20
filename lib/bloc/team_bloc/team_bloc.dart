import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_futbol/bloc/team_bloc/team_event.dart';
import 'package:one_futbol/bloc/team_bloc/team_state.dart';
import 'package:one_futbol/data/Repository/team_repository.dart';
import 'package:one_futbol/domain/funciones/generate_teams.dart';

class TeamBloc extends Bloc<TeamEvent, TeamState> {
  final TeamRepository repository;
  final GenerateTeams generateTeam;

  TeamBloc(this.repository, this.generateTeam) : super(TeamLoading()) {
    on<LoadTeam>(_onLoad);
    on<AddTeam>(_onAdd);
    on<UpdateTeam>(_onUpdate);
    on<DeleteTeam>(_onDelete);
    on<GenerateTeamEvent>(_onGenerate);
  }

  Future<void> _onLoad(LoadTeam event, Emitter<TeamState> emit) async {
    try {
      emit(TeamLoading());
      final teams = await repository.getAllTeams();
      emit(TeamLoaded(teams));
    } catch (e) {
      emit(TeamError('Error al cargar jugadores'));
    }
  }

  Future<void> _onAdd(AddTeam event, Emitter<TeamState> emit) async {
    await repository.addTeam(event.team);
    add(LoadTeam());
  }

  Future<void> _onUpdate(UpdateTeam event, Emitter<TeamState> emit) async {
    await repository.updateTeam(event.team);
    add(LoadTeam());
  }

  Future<void> _onDelete(DeleteTeam event, Emitter<TeamState> emit) async {
    await repository.deleteTeam(event.team);
    add(LoadTeam());
  }

  Future<void> _onGenerate(
      GenerateTeamEvent event, Emitter<TeamState> emit) async {
    final generated = generateTeam(
        event.selectedPlayers, event.count, event.playerLength, event.type);
    for (var team in generated) {
      await repository.addTeam(team);
    }

    final savedTeams = await repository.getAllTeams();
    emit(TeamLoaded(savedTeams));
  }
}
