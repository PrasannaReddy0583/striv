import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object?> get props => [];
}

class LoadEntrepreneurHome extends HomeEvent {
  const LoadEntrepreneurHome();
}

class LoadInvestorHome extends HomeEvent {
  const LoadInvestorHome();
}
