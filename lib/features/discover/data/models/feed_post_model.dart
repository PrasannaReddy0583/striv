import 'package:striv/features/discover/domain/entities/feed_post.dart';

class FeedPostModel extends FeedPost {
  const FeedPostModel({
    required super.id,
    required super.startupId,
    required super.startupName,
    required super.ownerUsername,
    super.avatarUrl,
    required super.caption,
    super.imageUrls,
    required super.likes,
    required super.comments,
    required super.timeAgo,
  });

  factory FeedPostModel.fromJson(Map<String, dynamic> json) {
    return FeedPostModel(
      id: json['id'] as String? ?? '',
      startupId: json['startupId'] as String? ?? '',
      startupName: json['startupName'] as String? ??
          json['username'] as String? ??
          '',
      ownerUsername: json['ownerUsername'] as String? ??
          json['username'] as String? ??
          '',
      avatarUrl: json['avatarUrl'] as String?,
      caption: json['caption'] as String? ?? json['text'] as String? ?? '',
      imageUrls: List<String>.from(json['imageUrls'] as List? ?? []),
      likes: json['likes'] as int? ?? 0,
      comments: json['comments'] as int? ?? 0,
      timeAgo: json['timeAgo'] as String? ?? '',
    );
  }
}
