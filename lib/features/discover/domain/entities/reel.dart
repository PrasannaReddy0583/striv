import 'package:equatable/equatable.dart';

class Reel extends Equatable {
  final String id;
  final String startupId;
  final String startupName;
  final String ownerUsername;
  final String videoUrl;
  final String caption;

  const Reel({
    required this.id,
    required this.startupId,
    required this.startupName,
    required this.ownerUsername,
    required this.videoUrl,
    required this.caption,
  });

  @override
  List<Object?> get props =>
      [id, startupId, startupName, ownerUsername, videoUrl, caption];
}
