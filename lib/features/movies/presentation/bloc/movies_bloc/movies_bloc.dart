import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/movie_entity.dart';
import '../../../domain/usecases/get_trending_movies_usecase.dart';
import '../../../domain/usecases/get_movie_detail_usecase.dart';
import '../../../domain/usecases/get_similar_movies_usecase.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetTrendingMoviesUseCase getTrendingMovies;
  final GetMovieDetailUseCase getMovieDetail;
  final GetSimilarMoviesUseCase getSimilarMovies;

  MoviesBloc({
    required this.getTrendingMovies,
    required this.getMovieDetail,
    required this.getSimilarMovies,
  }) : super(MoviesInitial()) {
    on<LoadTrendingMoviesEvent>(_onLoadTrendingMovies);
    on<LoadMovieDetailEvent>(_onLoadMovieDetail);
  }

  Future<void> _onLoadTrendingMovies(LoadTrendingMoviesEvent event, Emitter<MoviesState> emit) async {
    emit(MoviesLoading());
    final result = await getTrendingMovies();
    result.fold(
      (failure) => emit(MoviesError(failure.message)),
      (movies) => emit(MoviesLoaded(movies)),
    );
  }

  Future<void> _onLoadMovieDetail(LoadMovieDetailEvent event, Emitter<MoviesState> emit) async {
    emit(MoviesLoading());
    final detailResult = await getMovieDetail(event.movieId);
    final similarResult = await getSimilarMovies(event.movieId);

    detailResult.fold(
      (failure) => emit(MoviesError(failure.message)),
      (movie) {
        similarResult.fold(
          (failure) => emit(MovieDetailLoaded(movie: movie, similarMovies: const [])),
          (similar) => emit(MovieDetailLoaded(movie: movie, similarMovies: similar)),
        );
      },
    );
  }
}
