import 'package:equatable/equatable.dart';

abstract class DiscoverEvent extends Equatable {
  const DiscoverEvent();
  @override
  List<Object?> get props => [];
}

class LoadDiscover extends DiscoverEvent {
  const LoadDiscover();
}

class SwitchDiscoverTab extends DiscoverEvent {
  final int tabIndex;
  const SwitchDiscoverTab(this.tabIndex);

  @override
  List<Object?> get props => [tabIndex];
}
