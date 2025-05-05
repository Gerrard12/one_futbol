import 'package:one_futbol/data/data_provider/player_dao.dart';
import 'package:one_futbol/domain/domain.dart';

class PlayerRepository {
  final dao = PlayerDao();

  Future<List<Player>> getAllPlayers() async {
    final List<Player> datasetPlayer = await dao.readAll();
    return datasetPlayer;
  }

  Future<void> detelePlayer(Player player) async {
    await dao.delete(player);
  }

  Future<void> addPlayer(Player player) async {
    await dao.insert(player);
  }

  Future<void> updatePlayer(Player player) async {
    await dao.update(player);
  }
}
