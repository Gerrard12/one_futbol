import 'package:one_futbol/domain/domain.dart';

abstract class PlayerEvent {}

class LoadPlayer extends PlayerEvent {}

class AddPlayer extends PlayerEvent {
  final Player player;
  AddPlayer(this.player);
}

class UpdatePlayer extends PlayerEvent {
  final Player player;
  UpdatePlayer(this.player);
}

class DeletePlayer extends PlayerEvent {
  final Player player;
  DeletePlayer(this.player);
}
