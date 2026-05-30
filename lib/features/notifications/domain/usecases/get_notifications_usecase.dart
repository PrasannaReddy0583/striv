import 'package:striv/core/usecases/usecase.dart';
import 'package:striv/features/notifications/domain/entities/app_notification.dart';
import 'package:striv/features/notifications/domain/repositories/notifications_repository.dart';

class GetNotificationsUseCase
    implements UseCase<List<AppNotification>, NoParams> {
  final NotificationsRepository repository;
  GetNotificationsUseCase(this.repository);

  @override
  Future<List<AppNotification>> call(NoParams params) =>
      repository.getNotifications();
}
