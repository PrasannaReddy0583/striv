import 'package:striv/features/notifications/data/datasources/notifications_local_data_source.dart';
import 'package:striv/features/notifications/domain/entities/app_notification.dart';
import 'package:striv/features/notifications/domain/repositories/notifications_repository.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  final NotificationsLocalDataSource localDataSource;

  NotificationsRepositoryImpl(this.localDataSource);

  @override
  Future<List<AppNotification>> getNotifications() =>
      localDataSource.getNotifications();
}
