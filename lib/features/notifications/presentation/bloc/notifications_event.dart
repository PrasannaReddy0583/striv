import 'package:equatable/equatable.dart';

abstract class NotificationsEvent extends Equatable {
  const NotificationsEvent();
  @override
  List<Object?> get props => [];
}

class LoadNotifications extends NotificationsEvent {
  const LoadNotifications();
}

class MarkAllNotificationsRead extends NotificationsEvent {
  const MarkAllNotificationsRead();
}

class MarkNotificationRead extends NotificationsEvent {
  final String notificationId;
  const MarkNotificationRead(this.notificationId);

  @override
  List<Object?> get props => [notificationId];
}

class FilterNotifications extends NotificationsEvent {
  final int categoryIndex;
  const FilterNotifications(this.categoryIndex);

  @override
  List<Object?> get props => [categoryIndex];
}
