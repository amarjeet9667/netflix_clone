// lib/features/watchlist/presentation/bloc/watchlist_event.dart
part of 'watchlist_bloc.dart';

abstract class WatchlistEvent extends Equatable {
  const WatchlistEvent();
  @override
  List<Object?> get props => [];
}

/// Load My List + Continue Watching
class WatchlistFetchEvent extends WatchlistEvent {
  const WatchlistFetchEvent();
}

/// Add or remove an item (toggle)
class WatchlistToggleEvent extends WatchlistEvent {
  final String      contentId;
  final ContentType contentType;
  const WatchlistToggleEvent({
    required this.contentId,
    required this.contentType,
  });
  @override
  List<Object?> get props => [contentId, contentType];
}

/// Check whether a single item is in the list
class WatchlistCheckItemEvent extends WatchlistEvent {
  final String contentId;
  const WatchlistCheckItemEvent({required this.contentId});
  @override
  List<Object?> get props => [contentId];
}

/// Fetch continue watching row only
class WatchlistFetchContinueWatchingEvent extends WatchlistEvent {
  const WatchlistFetchContinueWatchingEvent();
}