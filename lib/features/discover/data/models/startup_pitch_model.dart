import 'package:striv/features/discover/domain/entities/startup_pitch.dart';

class StartupPitchModel extends StartupPitch {
  const StartupPitchModel({
    required super.id,
    required super.name,
    required super.tagline,
    required super.category,
    required super.posterImage,
    super.videoUrl,
    required super.fundingGoal,
    required super.stage,
  });

  factory StartupPitchModel.fromJson(Map<String, dynamic> json) {
    return StartupPitchModel(
      id: json['startupid'] as String? ?? json['id'] as String? ?? '',
      name: json['startupFullName'] as String? ?? json['name'] as String? ?? '',
      tagline: json['tagline'] as String? ?? '',
      category: json['category'] as String? ?? 'Startup',
      posterImage: json['posterImage'] as String? ?? '',
      videoUrl: json['videoUrl'] as String?,
      fundingGoal: json['fundingGoal'] as int? ?? 0,
      stage: json['stage'] as String? ?? 'Idea',
    );
  }
}
