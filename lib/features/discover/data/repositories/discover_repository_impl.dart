import 'package:striv/features/discover/data/datasources/discover_local_data_source.dart';
import 'package:striv/features/discover/domain/entities/feed_post.dart';
import 'package:striv/features/discover/domain/entities/reel.dart';
import 'package:striv/features/discover/domain/entities/startup_pitch.dart';
import 'package:striv/features/discover/domain/repositories/discover_repository.dart';

class DiscoverRepositoryImpl implements DiscoverRepository {
  final DiscoverLocalDataSource localDataSource;
  // Swap to DiscoverRemoteDataSource once backend is ready.

  DiscoverRepositoryImpl(this.localDataSource);

  @override
  Future<List<StartupPitch>> getSwipeablePitches() =>
      localDataSource.getSwipeablePitches();

  @override
  Future<List<FeedPost>> getFeedPosts() => localDataSource.getFeedPosts();

  @override
  Future<List<Reel>> getReels() => localDataSource.getReels();
}
