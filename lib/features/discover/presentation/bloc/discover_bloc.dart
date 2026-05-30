import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:striv/core/usecases/usecase.dart';
import 'package:striv/features/discover/domain/usecases/get_pitches_usecase.dart';
import 'package:striv/features/discover/presentation/bloc/discover_event.dart';
import 'package:striv/features/discover/presentation/bloc/discover_state.dart';

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  final GetSwipeablePitchesUseCase getSwipeablePitches;
  final GetFeedPostsUseCase getFeedPosts;
  final GetReelsUseCase getReels;

  DiscoverBloc({
    required this.getSwipeablePitches,
    required this.getFeedPosts,
    required this.getReels,
  }) : super(const DiscoverInitial()) {
    on<LoadDiscover>(_onLoadDiscover);
    on<SwitchDiscoverTab>(_onSwitchTab);
  }

  Future<void> _onLoadDiscover(
    LoadDiscover event,
    Emitter<DiscoverState> emit,
  ) async {
    emit(const DiscoverLoading());
    try {
      final pitches = await getSwipeablePitches(const NoParams());
      final posts = await getFeedPosts(const NoParams());
      final reels = await getReels(const NoParams());
      emit(DiscoverLoaded(pitches: pitches, posts: posts, reels: reels));
    } catch (e) {
      emit(DiscoverError(e.toString()));
    }
  }

  void _onSwitchTab(SwitchDiscoverTab event, Emitter<DiscoverState> emit) {
    final current = state;
    if (current is DiscoverLoaded) {
      emit(current.copyWith(activeTab: event.tabIndex));
    }
  }
}
