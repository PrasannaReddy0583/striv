import 'package:equatable/equatable.dart';

class FeedPost extends Equatable {
  final String id;
  final String startupId;
  final String startupName;
  final String ownerUsername;
  final String? avatarUrl;
  final String caption;
  final List<String> imageUrls;
  final int likes;
  final int comments;
  final String timeAgo;

  const FeedPost({
    required this.id,
    required this.startupId,
    required this.startupName,
    required this.ownerUsername,
    this.avatarUrl,
    required this.caption,
    this.imageUrls = const [],
    required this.likes,
    required this.comments,
    required this.timeAgo,
  });

  @override
  List<Object?> get props => [
        id,
        startupId,
        startupName,
        ownerUsername,
        caption,
        imageUrls,
        likes,
        comments,
        timeAgo,
      ];
}
