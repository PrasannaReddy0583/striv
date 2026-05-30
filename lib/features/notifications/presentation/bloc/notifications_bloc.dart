import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:striv/core/usecases/usecase.dart';
import 'package:striv/features/notifications/domain/usecases/get_notifications_usecase.dart';
import 'package:striv/features/notifications/presentation/bloc/notifications_event.dart';
import 'package:striv/features/notifications/presentation/bloc/notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final GetNotificationsUseCase getNotifications;

  NotificationsBloc({required this.getNotifications})
      : super(const NotificationsInitial()) {
    on<LoadNotifications>(_onLoad);
    on<MarkAllNotificationsRead>(_onMarkAllRead);
    on<MarkNotificationRead>(_onMarkOneRead);
    on<FilterNotifications>(_onFilter);
  }

  Future<void> _onLoad(
    LoadNotifications event,
    Emitter<NotificationsState> emit,
  ) async {
    emit(const NotificationsLoading());
    try {
      final items = await getNotifications(const NoParams());
      emit(NotificationsLoaded(all: items));
    } catch (e) {
      emit(NotificationsError(e.toString()));
    }
  }

  void _onMarkAllRead(
    MarkAllNotificationsRead event,
    Emitter<NotificationsState> emit,
  ) {
    final current = state;
    if (current is NotificationsLoaded) {
      emit(current.copyWith(
        all: current.all.map((n) => n.copyWith(isUnread: false)).toList(),
      ));
    }
  }

  void _onMarkOneRead(
    MarkNotificationRead event,
    Emitter<NotificationsState> emit,
  ) {
    final current = state;
    if (current is NotificationsLoaded) {
      emit(current.copyWith(
        all: current.all
            .map((n) => n.id == event.notificationId
                ? n.copyWith(isUnread: false)
                : n)
            .toList(),
      ));
    }
  }

  void _onFilter(FilterNotifications event, Emitter<NotificationsState> emit) {
    final current = state;
    if (current is NotificationsLoaded) {
      emit(current.copyWith(activeCategory: event.categoryIndex));
    }
  }
}
