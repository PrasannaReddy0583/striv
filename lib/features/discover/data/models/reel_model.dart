import 'package:striv/features/discover/domain/entities/reel.dart';

class ReelModel extends Reel {
  const ReelModel({
    required super.id,
    required super.startupId,
    required super.startupName,
    required super.ownerUsername,
    required super.videoUrl,
    required super.caption,
  });

  factory ReelModel.fromJson(Map<String, dynamic> json) {
    return ReelModel(
      id: json['reelid'] as String? ?? json['id'] as String? ?? '',
      startupId: json['startupid'] as String? ?? '',
      startupName: json['startupFullName'] as String? ?? '',
      ownerUsername: json['ownerUsername'] as String? ?? '',
      videoUrl: json['videoUrl'] as String? ?? '',
      caption: json['caption'] as String? ?? '',
    );
  }
}
