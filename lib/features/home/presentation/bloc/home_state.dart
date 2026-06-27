// lib/features/home/presentation/bloc/home_state.dart
part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object?> get props => [];
}

// ✅ Fixed: added const constructors
class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  final List<BannerEntity>      banners;
  final List<HomeSectionEntity> sections;

  const HomeLoaded({required this.banners, required this.sections});

  @override
  List<Object?> get props => [banners, sections];
}

// ✅ Fixed: consistent named param (matches bloc usage)
class HomeError extends HomeState {
  final String message;
  const HomeError({required this.message});
  @override
  List<Object?> get props => [message];
}