import 'package:striv/core/usecases/usecase.dart';
import 'package:striv/features/discover/domain/entities/feed_post.dart';
import 'package:striv/features/discover/domain/entities/reel.dart';
import 'package:striv/features/discover/domain/entities/startup_pitch.dart';
import 'package:striv/features/discover/domain/repositories/discover_repository.dart';

class GetSwipeablePitchesUseCase
    implements UseCase<List<StartupPitch>, NoParams> {
  final DiscoverRepository repository;
  GetSwipeablePitchesUseCase(this.repository);

  @override
  Future<List<StartupPitch>> call(NoParams params) =>
      repository.getSwipeablePitches();
}

class GetFeedPostsUseCase implements UseCase<List<FeedPost>, NoParams> {
  final DiscoverRepository repository;
  GetFeedPostsUseCase(this.repository);

  @override
  Future<List<FeedPost>> call(NoParams params) => repository.getFeedPosts();
}

class GetReelsUseCase implements UseCase<List<Reel>, NoParams> {
  final DiscoverRepository repository;
  GetReelsUseCase(this.repository);

  @override
  Future<List<Reel>> call(NoParams params) => repository.getReels();
}
