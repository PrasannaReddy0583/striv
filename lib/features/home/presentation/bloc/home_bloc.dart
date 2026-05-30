import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:striv/core/usecases/usecase.dart';
import 'package:striv/features/home/domain/usecases/get_entrepreneur_home_usecase.dart';
import 'package:striv/features/home/domain/usecases/get_investor_home_usecase.dart';
import 'package:striv/features/home/presentation/bloc/home_event.dart';
import 'package:striv/features/home/presentation/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetEntrepreneurPitchesUseCase getEntrepreneurPitches;
  final GetNewInvestorsUseCase getNewInvestors;
  final GetInvestorSmartMatchesUseCase getInvestorSmartMatches;

  HomeBloc({
    required this.getEntrepreneurPitches,
    required this.getNewInvestors,
    required this.getInvestorSmartMatches,
  }) : super(const HomeInitial()) {
    on<LoadEntrepreneurHome>(_onLoadEntrepreneurHome);
    on<LoadInvestorHome>(_onLoadInvestorHome);
  }

  Future<void> _onLoadEntrepreneurHome(
    LoadEntrepreneurHome event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());
    try {
      final pitches = await getEntrepreneurPitches(const NoParams());
      final investors = await getNewInvestors(const NoParams());
      emit(EntrepreneurHomeLoaded(pitches: pitches, newInvestors: investors));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> _onLoadInvestorHome(
    LoadInvestorHome event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());
    try {
      final matches = await getInvestorSmartMatches(const NoParams());
      emit(InvestorHomeLoaded(smartMatches: matches));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
