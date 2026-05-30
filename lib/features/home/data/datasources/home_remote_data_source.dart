// ---------------------------------------------------------------------------
// REMOTE DATA SOURCE — swap HomeLocalDataSourceImpl → HomeRemoteDataSourceImpl
// in injection_container.dart once the backend is ready.
// ---------------------------------------------------------------------------
import 'package:dio/dio.dart';
import 'package:striv/core/errors/exceptions.dart';
import 'package:striv/features/home/data/models/investor_profile_model.dart';
import 'package:striv/features/home/data/models/pitch_summary_model.dart';
import 'package:striv/features/home/data/models/smart_match_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<PitchSummaryModel>> getEntrepreneurPitches();
  Future<List<InvestorProfileModel>> getNewInvestors();
  Future<List<SmartMatchModel>> getInvestorSmartMatches();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final Dio dio;
  HomeRemoteDataSourceImpl(this.dio);

  @override
  Future<List<PitchSummaryModel>> getEntrepreneurPitches() async {
    try {
      final res = await dio.get('/home/pitches');
      return (res.data as List)
          .map((j) => PitchSummaryModel.fromJson(j as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to load pitches');
    }
  }

  @override
  Future<List<InvestorProfileModel>> getNewInvestors() async {
    try {
      final res = await dio.get('/home/investors');
      return (res.data as List)
          .map((j) => InvestorProfileModel.fromJson(j as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to load investors');
    }
  }

  @override
  Future<List<SmartMatchModel>> getInvestorSmartMatches() async {
    try {
      final res = await dio.get('/home/smart-matches');
      return (res.data as List)
          .map((j) => SmartMatchModel.fromJson(j as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to load smart matches');
    }
  }
}
