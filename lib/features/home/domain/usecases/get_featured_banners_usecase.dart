import 'package:dartz/dartz.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import '../entities/banner_entity.dart';
import '../repositories/home_repository.dart';

class GetFeaturedBannersUseCase {
  final HomeRepository repository;
  const GetFeaturedBannersUseCase(this.repository);

  Future<Either<Failure, List<BannerEntity>>> call() {
    return repository.getFeaturedBanners();
  }
}
