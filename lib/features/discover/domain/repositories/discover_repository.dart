import 'package:striv/features/discover/domain/entities/feed_post.dart';
import 'package:striv/features/discover/domain/entities/reel.dart';
import 'package:striv/features/discover/domain/entities/startup_pitch.dart';

abstract class DiscoverRepository {
  Future<List<StartupPitch>> getSwipeablePitches();
  Future<List<FeedPost>> getFeedPosts();
  Future<List<Reel>> getReels();
}
