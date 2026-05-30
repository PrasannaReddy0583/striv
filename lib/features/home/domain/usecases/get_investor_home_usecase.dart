import 'package:striv/core/usecases/usecase.dart';
import 'package:striv/features/home/domain/entities/smart_match.dart';
import 'package:striv/features/home/domain/repositories/home_repository.dart';

class GetInvestorSmartMatchesUseCase
    implements UseCase<List<SmartMatch>, NoParams> {
  final HomeRepository repository;
  GetInvestorSmartMatchesUseCase(this.repository);

  @override
  Future<List<SmartMatch>> call(NoParams params) =>
      repository.getInvestorSmartMatches();
}
