// ---------------------------------------------------------------------------
// REMOTE DATA SOURCE — swap DiscoverLocalDataSourceImpl → DiscoverRemoteDataSourceImpl
// in injection_container.dart once the backend is ready.
//
// The mock API URL below was previously hard-coded in discover_page.dart:
//   https://68e74faf10e3f82fbf3e9fac.mockapi.io/delance/post/entrupeneurs/get/posts
// ---------------------------------------------------------------------------
import 'package:dio/dio.dart';
import 'package:striv/core/errors/exceptions.dart';
import 'package:striv/features/discover/data/models/feed_post_model.dart';
import 'package:striv/features/discover/data/models/reel_model.dart';
import 'package:striv/features/discover/data/models/startup_pitch_model.dart';

abstract class DiscoverRemoteDataSource {
  Future<List<StartupPitchModel>> getSwipeablePitches();
  Future<List<FeedPostModel>> getFeedPosts();
  Future<List<ReelModel>> getReels();
}

class DiscoverRemoteDataSourceImpl implements DiscoverRemoteDataSource {
  final Dio dio;
  DiscoverRemoteDataSourceImpl(this.dio);

  @override
  Future<List<StartupPitchModel>> getSwipeablePitches() async {
    try {
      final res = await dio.get('/projects');
      return (res.data as List)
          .map((j) => StartupPitchModel.fromJson(j as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to load pitches');
    }
  }

  @override
  Future<List<FeedPostModel>> getFeedPosts() async {
    try {
      // TODO: replace with your own API endpoint when backend is ready.
      final res = await dio.get(
        'https://68e74faf10e3f82fbf3e9fac.mockapi.io/delance/post/entrupeneurs/get/posts',
      );
      return (res.data as List)
          .map((j) => FeedPostModel.fromJson(j as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to load posts');
    }
  }

  @override
  Future<List<ReelModel>> getReels() async {
    try {
      final res = await dio.get('/reels');
      return (res.data as List)
          .map((j) => ReelModel.fromJson(j as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to load reels');
    }
  }
}
