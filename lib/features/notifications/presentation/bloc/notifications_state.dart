import 'package:equatable/equatable.dart';
import 'package:striv/features/notifications/domain/entities/app_notification.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();
  @override
  List<Object?> get props => [];
}

class NotificationsInitial extends NotificationsState {
  const NotificationsInitial();
}

class NotificationsLoading extends NotificationsState {
  const NotificationsLoading();
}

class NotificationsLoaded extends NotificationsState {
  final List<AppNotification> all;
  final int activeCategory; // 0=All 1=Unread 2=Pitches 3=Messages

  const NotificationsLoaded({required this.all, this.activeCategory = 0});

  List<AppNotification> get filtered {
    switch (activeCategory) {
      case 1:
        return all.where((n) => n.isUnread).toList();
      case 2:
        return all
            .where((n) =>
                n.type == NotificationType.pitch ||
                n.type == NotificationType.connection)
            .toList();
      case 3:
        return all.where((n) => n.type == NotificationType.message).toList();
      default:
        return all;
    }
  }

  NotificationsLoaded copyWith({
    List<AppNotification>? all,
    int? activeCategory,
  }) =>
      NotificationsLoaded(
        all: all ?? this.all,
        activeCategory: activeCategory ?? this.activeCategory,
      );

  @override
  List<Object?> get props => [all, activeCategory];
}

class NotificationsError extends NotificationsState {
  final String message;
  const NotificationsError(this.message);

  @override
  List<Object?> get props => [message];
}
