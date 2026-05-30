import 'package:striv/features/notifications/domain/entities/app_notification.dart';

abstract class NotificationsRepository {
  Future<List<AppNotification>> getNotifications();
}
