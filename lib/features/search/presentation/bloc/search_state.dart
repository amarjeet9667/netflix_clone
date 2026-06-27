// lib/features/search/presentation/bloc/search_state.dart
part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
  @override
  List<Object?> get props => [];
}

/// Initial — show Browse by Genre
class SearchInitial extends SearchState {
  final List<GenreEntity> genres;
  const SearchInitial({this.genres = const []});
  @override
  List<Object?> get props => [genres];
}

/// Typing but query too short
class SearchTyping extends SearchState {
  final String query;
  const SearchTyping({required this.query});
  @override
  List<Object?> get props => [query];
}

/// Search request in flight
class SearchLoading extends SearchState {
  const SearchLoading();
}

/// Results returned
class SearchLoaded extends SearchState {
  final List<SearchResultEntity> results;
  final String                   query;
  const SearchLoaded({required this.results, required this.query});
  @override
  List<Object?> get props => [results, query];
}

/// Query returned no matches
class SearchEmpty extends SearchState {
  final String query;
  const SearchEmpty({required this.query});
  @override
  List<Object?> get props => [query];
}

/// Genres loaded for browse view
class SearchGenresLoaded extends SearchState {
  final List<GenreEntity> genres;
  const SearchGenresLoaded({required this.genres});
  @override
  List<Object?> get props => [genres];
}

class SearchError extends SearchState {
  final String message;
  const SearchError({required this.message});
  @override
  List<Object?> get props => [message];
}