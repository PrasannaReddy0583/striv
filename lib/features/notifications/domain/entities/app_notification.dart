import 'package:equatable/equatable.dart';

enum NotificationType { connection, pitch, message, community, general }

class AppNotification extends Equatable {
  final String id;
  final String title;
  final String time;
  final NotificationType type;
  final bool isUnread;
  final String? avatarUrl;
  final String? avatarInitials;

  const AppNotification({
    required this.id,
    required this.title,
    required this.time,
    required this.type,
    required this.isUnread,
    this.avatarUrl,
    this.avatarInitials,
  });

  AppNotification copyWith({bool? isUnread}) => AppNotification(
        id: id,
        title: title,
        time: time,
        type: type,
        isUnread: isUnread ?? this.isUnread,
        avatarUrl: avatarUrl,
        avatarInitials: avatarInitials,
      );

  @override
  List<Object?> get props =>
      [id, title, time, type, isUnread, avatarUrl, avatarInitials];
}
