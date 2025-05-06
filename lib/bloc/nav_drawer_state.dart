import 'package:equatable/equatable.dart';

enum NavItem {
  homeView,
  profileView,
  orderView,
  cartView,
  perfilView,
}

class NavDrawerState extends Equatable {
  final NavItem selectedItem;

  const NavDrawerState(this.selectedItem);

  @override
  // ignore: override_on_non_overriding_member
  List<Object?> get props => [
        selectedItem,
      ];
}
