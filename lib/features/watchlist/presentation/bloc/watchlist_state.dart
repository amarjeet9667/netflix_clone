// lib/features/watchlist/presentation/bloc/watchlist_state.dart
part of 'watchlist_bloc.dart';

abstract class WatchlistState extends Equatable {
  const WatchlistState();
  @override
  List<Object?> get props => [];
}

class WatchlistInitial extends WatchlistState {
  const WatchlistInitial();
}

class WatchlistLoading extends WatchlistState {
  const WatchlistLoading();
}

class WatchlistLoaded extends WatchlistState {
  final List<WatchlistEntity> myList;
  final List<WatchlistEntity> continueWatching;
  const WatchlistLoaded({
    required this.myList,
    this.continueWatching = const [],
  });
  @override
  List<Object?> get props => [myList, continueWatching];
}

/// Returned after a toggle so UI can update the add/remove icon instantly
class WatchlistItemToggled extends WatchlistState {
  final List<WatchlistEntity> myList;
  final List<WatchlistEntity> continueWatching;
  final String                contentId;
  final bool                  isAdded;
  const WatchlistItemToggled({
    required this.myList,
    required this.continueWatching,
    required this.contentId,
    required this.isAdded,
  });
  @override
  List<Object?> get props => [myList, continueWatching, contentId, isAdded];
}

class WatchlistError extends WatchlistState {
  final String message;
  const WatchlistError({required this.message});
  @override
  List<Object?> get props => [message];
}