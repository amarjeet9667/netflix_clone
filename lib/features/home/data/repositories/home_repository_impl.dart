import 'package:dartz/dartz.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import 'package:netflix_clone/core/errors/error_mapper.dart';
import 'package:netflix_clone/core/networks/network_info.dart';
import '../../domain/entities/banner_entity.dart';
import '../../domain/entities/home_section_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_datasource.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  HomeRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<BannerEntity>>> getFeaturedBanners() async {
    try {
      final banners = await remoteDataSource.getFeaturedBanners();
      return Right(banners);
    } on Exception catch (e) {
      return Left(ErrorMapper.fromException(e));
    }
  }

  @override
  Future<Either<Failure, List<HomeSectionEntity>>> getHomeSections() async {
    try {
      final sections = await remoteDataSource.getHomeSections();
      return Right(sections);
    } on Exception catch (e) {
      return Left(ErrorMapper.fromException(e));
    }
  }
}
