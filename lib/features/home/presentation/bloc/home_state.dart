import 'package:equatable/equatable.dart';
import 'package:striv/features/home/domain/entities/investor_profile.dart';
import 'package:striv/features/home/domain/entities/pitch_summary.dart';
import 'package:striv/features/home/domain/entities/smart_match.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class EntrepreneurHomeLoaded extends HomeState {
  final List<PitchSummary> pitches;
  final List<InvestorProfile> newInvestors;

  const EntrepreneurHomeLoaded({
    required this.pitches,
    required this.newInvestors,
  });

  @override
  List<Object?> get props => [pitches, newInvestors];
}

class InvestorHomeLoaded extends HomeState {
  final List<SmartMatch> smartMatches;

  const InvestorHomeLoaded({required this.smartMatches});

  @override
  List<Object?> get props => [smartMatches];
}

class HomeError extends HomeState {
  final String message;
  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
