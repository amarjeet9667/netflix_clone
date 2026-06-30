// lib/features/tv_shows/domain/usecases/get_show_detail_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import '../entities/series_entity.dart';
import '../repositories/tvshow_repository.dart';

class ShowDetailParams extends Equatable {
  final int showId;
  const ShowDetailParams({required this.showId});
  @override
  List<Object?> get props => [showId];
}

class GetShowDetailUseCase {
  final TVShowRepository repository;
  const GetShowDetailUseCase(this.repository);

  Future<Either<Failure, SeriesEntity>> call(ShowDetailParams params) {
    return repository.getShowDetail(params.showId);
  }
}