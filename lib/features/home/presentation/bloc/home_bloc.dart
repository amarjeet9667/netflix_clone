import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/banner_entity.dart';
import '../../domain/entities/home_section_entity.dart';
import '../../domain/usecases/get_featured_banners_usecase.dart';
import '../../domain/usecases/get_home_sections_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetFeaturedBannersUseCase getFeaturedBanners;
  final GetHomeSectionsUseCase getHomeSections;

  HomeBloc({
    required this.getFeaturedBanners,
    required this.getHomeSections,
  }) : super(HomeInitial()) {
    on<LoadHomeDataEvent>(_onLoadHomeData);
  }

  Future<void> _onLoadHomeData(LoadHomeDataEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    final bannersResult = await getFeaturedBanners();
    final sectionsResult = await getHomeSections();

    bannersResult.fold(
      (failure) => emit(HomeError(failure.message)),
      (banners) {
        sectionsResult.fold(
          (failure) => emit(HomeError(failure.message)),
          (sections) => emit(HomeLoaded(banners: banners, sections: sections)),
        );
      },
    );
  }
}
