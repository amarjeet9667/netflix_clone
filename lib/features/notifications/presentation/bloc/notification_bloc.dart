// lib/features/notifications/presentation/bloc/notification_bloc.dart
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:netflix_clone/features/notifications/domain/entities/notification_entity.dart';
import 'package:netflix_clone/features/notifications/domain/usecases/get_notifications_usecase.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetNotificationsUseCase getNotifications;

  NotificationBloc({
    required this.getNotifications,
  }) : super(const NotificationInitial()) {
    on<NotificationFetchEvent>(_onFetch);
    on<NotificationRegisterTokenEvent>(_onRegisterToken);
    on<NotificationMarkReadEvent>(_onMarkRead);
    on<NotificationMarkAllReadEvent>(_onMarkAllRead);
    on<NotificationReceivedEvent>(_onReceived);
  }

  // ── Fetch ─────────────────────────────────────────────────
  Future<void> _onFetch(
    NotificationFetchEvent event,
    Emitter<NotificationState> emit,
  ) async {
    emit(const NotificationLoading());
    final result = await getNotifications();
    result.fold(
      (failure) => emit(NotificationError(message: failure.message)),
      (list)    => emit(NotificationLoaded(notifications: list)),
    );
  }

  // ── Register FCM token ────────────────────────────────────
  Future<void> _onRegisterToken(
    NotificationRegisterTokenEvent event,
    Emitter<NotificationState>     emit,
  ) async {
    // TODO: wire to RegisterTokenUseCase
    // Fire-and-forget — no UI state change needed
  }

  // ── Mark single read ──────────────────────────────────────
  void _onMarkRead(
    NotificationMarkReadEvent  event,
    Emitter<NotificationState> emit,
  ) {
    if (state is! NotificationLoaded) return;
    emit((state as NotificationLoaded).markRead(event.notificationId));
  }

  // ── Mark all read ─────────────────────────────────────────
  void _onMarkAllRead(
    NotificationMarkAllReadEvent event,
    Emitter<NotificationState>   emit,
  ) {
    if (state is! NotificationLoaded) return;
    emit((state as NotificationLoaded).markAllRead());
  }

  // ── New push received while app is open ───────────────────
  void _onReceived(
    NotificationReceivedEvent  event,
    Emitter<NotificationState> emit,
  ) {
    if (state is! NotificationLoaded) return;
    final current = (state as NotificationLoaded).notifications;
    emit(NotificationLoaded(
      notifications: [event.notification, ...current],
    ));
  }
}