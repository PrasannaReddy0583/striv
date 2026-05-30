import 'package:striv/core/usecases/usecase.dart';
import 'package:striv/features/home/domain/entities/investor_profile.dart';
import 'package:striv/features/home/domain/entities/pitch_summary.dart';
import 'package:striv/features/home/domain/repositories/home_repository.dart';

class GetEntrepreneurPitchesUseCase
    implements UseCase<List<PitchSummary>, NoParams> {
  final HomeRepository repository;
  GetEntrepreneurPitchesUseCase(this.repository);

  @override
  Future<List<PitchSummary>> call(NoParams params) =>
      repository.getEntrepreneurPitches();
}

class GetNewInvestorsUseCase
    implements UseCase<List<InvestorProfile>, NoParams> {
  final HomeRepository repository;
  GetNewInvestorsUseCase(this.repository);

  @override
  Future<List<InvestorProfile>> call(NoParams params) =>
      repository.getNewInvestors();
}
