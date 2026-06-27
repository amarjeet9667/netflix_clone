// lib/features/search/presentation/bloc/search_event.dart
part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
  @override
  List<Object?> get props => [];
}

class SearchQueryChangedEvent extends SearchEvent {
  final String query;
  const SearchQueryChangedEvent({required this.query});
  @override
  List<Object?> get props => [query];
}

class SearchFetchGenresEvent extends SearchEvent {
  const SearchFetchGenresEvent();
}

class SearchClearEvent extends SearchEvent {
  const SearchClearEvent();
}