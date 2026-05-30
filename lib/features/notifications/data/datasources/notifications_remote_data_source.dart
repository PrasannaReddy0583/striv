// ---------------------------------------------------------------------------
// REMOTE DATA SOURCE — swap local → remote in injection_container.dart
// once the backend is ready.
// ---------------------------------------------------------------------------
import 'package:dio/dio.dart';
import 'package:striv/core/errors/exceptions.dart';
import 'package:striv/features/notifications/data/models/notification_model.dart';

abstract class NotificationsRemoteDataSource {
  Future<List<NotificationModel>> getNotifications();
}

class NotificationsRemoteDataSourceImpl
    implements NotificationsRemoteDataSource {
  final Dio dio;
  NotificationsRemoteDataSourceImpl(this.dio);

  @override
  Future<List<NotificationModel>> getNotifications() async {
    try {
      final res = await dio.get('/notifications');
      return (res.data as List)
          .map((j) => NotificationModel.fromJson(j as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to load notifications');
    }
  }
}
