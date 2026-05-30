import 'package:striv/features/notifications/domain/entities/app_notification.dart';

class NotificationModel extends AppNotification {
  const NotificationModel({
    required super.id,
    required super.title,
    required super.time,
    required super.type,
    required super.isUnread,
    super.avatarUrl,
    super.avatarInitials,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as String,
      title: json['title'] as String,
      time: json['time'] as String,
      type: NotificationType.values.firstWhere(
        (t) => t.name == (json['type'] as String? ?? 'general'),
        orElse: () => NotificationType.general,
      ),
      isUnread: json['isUnread'] as bool? ?? false,
      avatarUrl: json['avatarUrl'] as String?,
      avatarInitials: json['avatarInitials'] as String?,
    );
  }
}
