import 'package:striv/features/notifications/data/models/notification_model.dart';
import 'package:striv/features/notifications/domain/entities/app_notification.dart';

abstract class NotificationsLocalDataSource {
  Future<List<NotificationModel>> getNotifications();
}

class NotificationsLocalDataSourceImpl implements NotificationsLocalDataSource {
  @override
  Future<List<NotificationModel>> getNotifications() async {
    return const [
      NotificationModel(
        id: 'n1',
        title: 'Tech Innovators Inc. requested to connect',
        time: '2h ago',
        type: NotificationType.connection,
        isUnread: true,
      ),
      NotificationModel(
        id: 'n2',
        title: 'You received new feedback on your pitch',
        time: '3h ago',
        type: NotificationType.pitch,
        isUnread: true,
      ),
      NotificationModel(
        id: 'n3',
        title: 'Ethan Carter messaged you',
        time: '4h ago',
        type: NotificationType.message,
        isUnread: true,
        avatarInitials: 'E',
      ),
      NotificationModel(
        id: 'n4',
        title: 'New post in AI Investors Group',
        time: '5h ago',
        type: NotificationType.community,
        isUnread: false,
      ),
      NotificationModel(
        id: 'n5',
        title: 'Olivia Bennett messaged you',
        time: 'Yesterday',
        type: NotificationType.message,
        isUnread: false,
        avatarUrl: 'https://i.pravatar.cc/150?img=47',
      ),
    ];
  }
}
