import 'package:dartz/dartz.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import '../entities/banner_entity.dart';
import '../entities/home_section_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<BannerEntity>>> getFeaturedBanners();
  Future<Either<Failure, List<HomeSectionEntity>>> getHomeSections();
}
