// lib/features/watchlist/presentation/bloc/watchlist_bloc.dart
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:netflix_clone/features/watchlist/domain/entities/watchlist_entity.dart';
import 'package:netflix_clone/features/watchlist/domain/usecases/toggle_watchlist_usecase.dart';
import 'package:netflix_clone/features/watchlist/domain/usecases/get_my_list_usecase.dart';
import 'package:netflix_clone/features/watchlist/domain/usecases/get_continue_watching_usecase.dart';
import 'package:netflix_clone/shared/enums/content_type.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final ToggleWatchlistUseCase    toggleWatchlist;
  final GetMyListUseCase          getMyList;
  final GetContinueWatchingUseCase getContinueWatching;

  WatchlistBloc({
    required this.toggleWatchlist,
    required this.getMyList,
    required this.getContinueWatching,
  }) : super(const WatchlistInitial()) {
    on<WatchlistFetchEvent>(_onFetch);
    on<WatchlistToggleEvent>(_onToggle);
    on<WatchlistCheckItemEvent>(_onCheckItem);
    on<WatchlistFetchContinueWatchingEvent>(_onFetchContinue);
  }

  // ── Fetch my list + continue watching ────────────────────
  Future<void> _onFetch(
    WatchlistFetchEvent  event,
    Emitter<WatchlistState> emit,
  ) async {
    emit(const WatchlistLoading());

    final myListResult      = await getMyList();
    final continueResult    = await getContinueWatching();

    myListResult.fold(
      (failure) => emit(WatchlistError(message: failure.message)),
      (myList) {
        final continueWatching = continueResult.fold(
          (_)       => <WatchlistEntity>[],
          (list)    => list,
        );
        emit(WatchlistLoaded(
          myList:           myList,
          continueWatching: continueWatching,
        ));
      },
    );
  }

  // ── Toggle add / remove ──────────────────────────────────
  Future<void> _onToggle(
    WatchlistToggleEvent event,
    Emitter<WatchlistState> emit,
  ) async {
    // Keep existing list visible while toggling
    final currentMyList = state is WatchlistLoaded
        ? (state as WatchlistLoaded).myList
        : state is WatchlistItemToggled
            ? (state as WatchlistItemToggled).myList
            : <WatchlistEntity>[];

    final currentContinue = state is WatchlistLoaded
        ? (state as WatchlistLoaded).continueWatching
        : state is WatchlistItemToggled
            ? (state as WatchlistItemToggled).continueWatching
            : <WatchlistEntity>[];

    final result = await toggleWatchlist(
      ToggleParams(
        contentId:   event.contentId,
        contentType: event.contentType,
      ),
    );

    result.fold(
      (failure) => emit(WatchlistError(message: failure.message)),
      (isAdded) {
        // Optimistic update: add or remove from local list
        List<WatchlistEntity> updated;
        if (isAdded) {
          updated = [
            ...currentMyList,
            WatchlistEntity(
              id:          event.contentId,
              contentId:   event.contentId,
              contentType: event.contentType,
              addedAt:     DateTime.now(),
            ),
          ];
        } else {
          updated = currentMyList
              .where((w) => w.contentId != event.contentId)
              .toList();
        }
        emit(WatchlistItemToggled(
          myList:           updated,
          continueWatching: currentContinue,
          contentId:        event.contentId,
          isAdded:          isAdded,
        ));
      },
    );
  }

  // ── Check single item ────────────────────────────────────
  void _onCheckItem(
    WatchlistCheckItemEvent event,
    Emitter<WatchlistState> emit,
  ) {
    // No-op: UI reads from WatchlistLoaded.myList directly
  }

  // ── Fetch continue watching only ─────────────────────────
  Future<void> _onFetchContinue(
    WatchlistFetchContinueWatchingEvent event,
    Emitter<WatchlistState>             emit,
  ) async {
    final result = await getContinueWatching();
    result.fold(
      (failure) => emit(WatchlistError(message: failure.message)),
      (list) {
        final myList = state is WatchlistLoaded
            ? (state as WatchlistLoaded).myList
            : <WatchlistEntity>[];
        emit(WatchlistLoaded(
          myList:           myList,
          continueWatching: list,
        ));
      },
    );
  }
}