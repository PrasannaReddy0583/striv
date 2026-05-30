import 'package:equatable/equatable.dart';

class StartupPitch extends Equatable {
  final String id;
  final String name;
  final String tagline;
  final String category;
  final String posterImage;
  final String? videoUrl;
  final int fundingGoal;
  final String stage;

  const StartupPitch({
    required this.id,
    required this.name,
    required this.tagline,
    required this.category,
    required this.posterImage,
    this.videoUrl,
    required this.fundingGoal,
    required this.stage,
  });

  @override
  List<Object?> get props =>
      [id, name, tagline, category, posterImage, videoUrl, fundingGoal, stage];
}
