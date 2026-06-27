import 'package:dartz/dartz.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import '../entities/home_section_entity.dart';
import '../repositories/home_repository.dart';

class GetHomeSectionsUseCase {
  final HomeRepository repository;
  const GetHomeSectionsUseCase(this.repository);

  Future<Either<Failure, List<HomeSectionEntity>>> call() {
    return repository.getHomeSections();
  }
}
