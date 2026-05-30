import 'package:striv/features/home/data/models/investor_profile_model.dart';
import 'package:striv/features/home/data/models/pitch_summary_model.dart';
import 'package:striv/features/home/data/models/smart_match_model.dart';

abstract class HomeLocalDataSource {
  Future<List<PitchSummaryModel>> getEntrepreneurPitches();
  Future<List<InvestorProfileModel>> getNewInvestors();
  Future<List<SmartMatchModel>> getInvestorSmartMatches();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  @override
  Future<List<PitchSummaryModel>> getEntrepreneurPitches() async {
    return [
      const PitchSummaryModel(
        id: '1',
        title: 'EcoTech Solutions',
        subtitle: 'Fintech · Seed Stage',
        fundingProgress: 0.65,
        investors: 12,
        views: 340,
        feedback: 8,
        logoUrl: 'https://via.placeholder.com/64',
      ),
      const PitchSummaryModel(
        id: '2',
        title: 'MediLink AI',
        subtitle: 'HealthTech · MVP Stage',
        fundingProgress: 0.40,
        investors: 5,
        views: 210,
        feedback: 3,
        logoUrl: 'https://via.placeholder.com/64',
      ),
      const PitchSummaryModel(
        id: '3',
        title: 'EduBridge',
        subtitle: 'EdTech · Pre-Seed',
        fundingProgress: 0.20,
        investors: 2,
        views: 98,
        feedback: 1,
        logoUrl: 'https://via.placeholder.com/64',
      ),
    ];
  }

  @override
  Future<List<InvestorProfileModel>> getNewInvestors() async {
    return [
      const InvestorProfileModel(
        id: 'i1',
        name: 'Sarah Mitchell',
        role: 'Angel Investor',
        avatarUrl:
            'https://plus.unsplash.com/premium_photo-1661432963180-11f554ff1ced?q=80&w=400',
        focusAreas: ['Fintech', 'SaaS'],
      ),
      const InvestorProfileModel(
        id: 'i2',
        name: 'James Carter',
        role: 'VC Partner',
        avatarUrl:
            'https://images.unsplash.com/photo-1607746882042-944635dfe10e?q=80&w=400',
        focusAreas: ['HealthTech', 'AI'],
      ),
      const InvestorProfileModel(
        id: 'i3',
        name: 'Priya Sharma',
        role: 'Impact Investor',
        avatarUrl:
            'https://images.unsplash.com/photo-1573497019418-b400bb3ab074?q=80&w=400',
        focusAreas: ['CleanTech', 'EdTech'],
      ),
    ];
  }

  @override
  Future<List<SmartMatchModel>> getInvestorSmartMatches() async {
    return [
      const SmartMatchModel(
        id: 's1',
        name: 'EcoTech Solutions',
        role: 'Entrepreneur',
        avatarUrl: 'https://via.placeholder.com/64',
        matchScore: 92,
      ),
      const SmartMatchModel(
        id: 's2',
        name: 'MediLink AI',
        role: 'Entrepreneur',
        avatarUrl: 'https://via.placeholder.com/64',
        matchScore: 87,
      ),
      const SmartMatchModel(
        id: 's3',
        name: 'EduBridge',
        role: 'Entrepreneur',
        avatarUrl: 'https://via.placeholder.com/64',
        matchScore: 81,
      ),
    ];
  }
}
