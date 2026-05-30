import 'package:equatable/equatable.dart';
import 'package:striv/features/discover/domain/entities/feed_post.dart';
import 'package:striv/features/discover/domain/entities/reel.dart';
import 'package:striv/features/discover/domain/entities/startup_pitch.dart';

abstract class DiscoverState extends Equatable {
  const DiscoverState();
  @override
  List<Object?> get props => [];
}

class DiscoverInitial extends DiscoverState {
  const DiscoverInitial();
}

class DiscoverLoading extends DiscoverState {
  const DiscoverLoading();
}

class DiscoverLoaded extends DiscoverState {
  final List<StartupPitch> pitches;
  final List<FeedPost> posts;
  final List<Reel> reels;
  final int activeTab;

  const DiscoverLoaded({
    required this.pitches,
    required this.posts,
    required this.reels,
    this.activeTab = 0,
  });

  DiscoverLoaded copyWith({int? activeTab}) => DiscoverLoaded(
        pitches: pitches,
        posts: posts,
        reels: reels,
        activeTab: activeTab ?? this.activeTab,
      );

  @override
  List<Object?> get props => [pitches, posts, reels, activeTab];
}

class DiscoverError extends DiscoverState {
  final String message;
  const DiscoverError(this.message);

  @override
  List<Object?> get props => [message];
}
