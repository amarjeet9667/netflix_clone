// lib/features/home/presentation/bloc/home_bloc.dart
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
  final GetHomeSectionsUseCase    getHomeSections;

  HomeBloc({
    required this.getFeaturedBanners,
    required this.getHomeSections,
  // ✅ Fixed: const HomeInitial()
  }) : super(const HomeInitial()) {
    on<LoadHomeDataEvent>(_onLoadHomeData);
    on<RefreshHomeDataEvent>(_onRefreshHomeData);
  }

  Future<void> _onLoadHomeData(
    LoadHomeDataEvent  event,
    Emitter<HomeState> emit,
  ) async {
    // ✅ Fixed: const emits
    emit( HomeLoading());
    await _fetchAndEmit(emit);
  }

  Future<void> _onRefreshHomeData(
    RefreshHomeDataEvent event,
    Emitter<HomeState>   emit,
  ) async {
    // Keep existing data visible while refreshing
    if (state is HomeLoaded) {
      final current = state as HomeLoaded;
      emit(HomeLoaded(
        banners:  current.banners,
        sections: current.sections,
      ));
    } else {
      emit( HomeLoading());
    }
    await _fetchAndEmit(emit);
  }

  Future<void> _fetchAndEmit(Emitter<HomeState> emit) async {
    final bannersResult  = await getFeaturedBanners();
    final sectionsResult = await getHomeSections();

    bannersResult.fold(
      // ✅ Fixed: named param to match HomeError({required message})
      (failure) => emit(HomeError(message: failure.message)),
      (banners) {
        sectionsResult.fold(
          (failure) => emit(HomeError(message: failure.message)),
          (sections) => emit(HomeLoaded(
            banners:  banners,
            sections: sections,
          )),
        );
      },
    );
  }
}