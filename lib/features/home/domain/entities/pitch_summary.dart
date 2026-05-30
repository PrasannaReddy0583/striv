import 'package:equatable/equatable.dart';

class PitchSummary extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final double fundingProgress; // 0.0 – 1.0
  final int investors;
  final int views;
  final int feedback;
  final String? logoUrl;

  const PitchSummary({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.fundingProgress,
    required this.investors,
    required this.views,
    required this.feedback,
    this.logoUrl,
  });

  @override
  List<Object?> get props =>
      [id, title, subtitle, fundingProgress, investors, views, feedback, logoUrl];
}
