import 'package:striv/features/home/domain/entities/investor_profile.dart';

class InvestorProfileModel extends InvestorProfile {
  const InvestorProfileModel({
    required super.id,
    required super.name,
    required super.role,
    required super.avatarUrl,
    super.focusAreas,
  });

  factory InvestorProfileModel.fromJson(Map<String, dynamic> json) {
    return InvestorProfileModel(
      id: json['id'] as String,
      name: json['name'] as String,
      role: json['role'] as String? ?? 'Investor',
      avatarUrl: json['avatarUrl'] as String? ?? '',
      focusAreas: List<String>.from(json['focusAreas'] as List? ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'role': role,
        'avatarUrl': avatarUrl,
        'focusAreas': focusAreas,
      };
}
