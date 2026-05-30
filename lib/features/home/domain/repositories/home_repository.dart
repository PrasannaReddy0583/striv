import 'package:striv/features/home/domain/entities/investor_profile.dart';
import 'package:striv/features/home/domain/entities/pitch_summary.dart';
import 'package:striv/features/home/domain/entities/smart_match.dart';

abstract class HomeRepository {
  Future<List<PitchSummary>> getEntrepreneurPitches();
  Future<List<InvestorProfile>> getNewInvestors();
  Future<List<SmartMatch>> getInvestorSmartMatches();
}
