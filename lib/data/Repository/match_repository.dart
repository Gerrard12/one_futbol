import 'package:one_futbol/data/data_provider/match_dao.dart';
import 'package:one_futbol/domain/domain.dart';

class MatchesRepository {
  final dao = MatchDao();

  Future<List<MatchModel>> getAllMatches() async {
    final List<MatchModel> datasetMatch = await dao.readAllMatches();
    return datasetMatch;
  }

  Future<void> deleteMatch(MatchModel match) async {
    await dao.deletematch(match);
  }

  Future<void> addMatch(MatchModel match) async {
    await dao.insertmatch(match);
  }

  Future<void> updateMatch(MatchModel match) async {
    await dao.updatematch(match);
  }

  Future<void> deleteAllMatches() async {
    await dao.deleteAll();
  }
}
