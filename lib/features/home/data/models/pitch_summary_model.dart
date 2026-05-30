import 'package:striv/features/home/domain/entities/pitch_summary.dart';

class PitchSummaryModel extends PitchSummary {
  const PitchSummaryModel({
    required super.id,
    required super.title,
    required super.subtitle,
    required super.fundingProgress,
    required super.investors,
    required super.views,
    required super.feedback,
    super.logoUrl,
  });

  factory PitchSummaryModel.fromJson(Map<String, dynamic> json) {
    return PitchSummaryModel(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String? ?? '',
      fundingProgress: (json['fundingProgress'] as num?)?.toDouble() ?? 0.0,
      investors: json['investors'] as int? ?? 0,
      views: json['views'] as int? ?? 0,
      feedback: json['feedback'] as int? ?? 0,
      logoUrl: json['logoUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'subtitle': subtitle,
        'fundingProgress': fundingProgress,
        'investors': investors,
        'views': views,
        'feedback': feedback,
        'logoUrl': logoUrl,
      };
}
