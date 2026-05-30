import 'package:striv/features/home/data/datasources/home_local_data_source.dart';
import 'package:striv/features/home/domain/entities/investor_profile.dart';
import 'package:striv/features/home/domain/entities/pitch_summary.dart';
import 'package:striv/features/home/domain/entities/smart_match.dart';
import 'package:striv/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeLocalDataSource localDataSource;
  // Swap to HomeRemoteDataSource once backend is ready.

  HomeRepositoryImpl(this.localDataSource);

  @override
  Future<List<PitchSummary>> getEntrepreneurPitches() =>
      localDataSource.getEntrepreneurPitches();

  @override
  Future<List<InvestorProfile>> getNewInvestors() =>
      localDataSource.getNewInvestors();

  @override
  Future<List<SmartMatch>> getInvestorSmartMatches() =>
      localDataSource.getInvestorSmartMatches();
}
