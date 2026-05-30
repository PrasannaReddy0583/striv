import 'package:striv/features/home/domain/entities/smart_match.dart';

class SmartMatchModel extends SmartMatch {
  const SmartMatchModel({
    required super.id,
    required super.name,
    required super.role,
    required super.avatarUrl,
    required super.matchScore,
  });

  factory SmartMatchModel.fromJson(Map<String, dynamic> json) {
    return SmartMatchModel(
      id: json['id'] as String,
      name: json['name'] as String,
      role: json['role'] as String? ?? 'Entrepreneur',
      avatarUrl: json['avatarUrl'] as String? ?? '',
      matchScore: json['matchScore'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'role': role,
        'avatarUrl': avatarUrl,
        'matchScore': matchScore,
      };
}
