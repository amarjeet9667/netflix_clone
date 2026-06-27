// lib/features/user/presentation/bloc/profile_bloc.dart
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:netflix_clone/features/user/domain/entities/profile_entity.dart';
import 'package:netflix_clone/features/user/domain/usecases/get_profile_usecase.dart';
import 'package:netflix_clone/features/user/domain/usecases/update_profile_usecase.dart';
import 'package:netflix_clone/features/user/domain/usecases/switch_profile_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase    getProfile;
  final UpdateProfileUseCase updateProfile;
  final SwitchProfileUseCase switchProfile;

  ProfileBloc({
    required this.getProfile,
    required this.updateProfile,
    required this.switchProfile,
  }) : super(const ProfileInitial()) {
    on<ProfileFetchAllEvent>(_onFetchAll);
    on<ProfileSelectEvent>(_onSelect);
    on<ProfileUpdateEvent>(_onUpdate);
    on<ProfileCreateEvent>(_onCreate);
    on<ProfileDeleteEvent>(_onDelete);
    on<ProfileSwitchEvent>(_onSwitch);
  }

  // ── Fetch all profiles ────────────────────────────────────
  Future<void> _onFetchAll(
    ProfileFetchAllEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileLoading());
    final result = await getProfile();
    result.fold(
      (failure) => emit(ProfileError(message: failure.message)),
      (profiles) => emit(ProfileListLoaded(profiles: profiles)),
    );
  }

  // ── Select (who-is-watching tap) ─────────────────────────
  Future<void> _onSelect(
    ProfileSelectEvent   event,
    Emitter<ProfileState> emit,
  ) async {
    if (state is! ProfileListLoaded) return;
    final profiles = (state as ProfileListLoaded).profiles;
    try {
      final active = profiles.firstWhere(
        (p) => p.id == event.profileId,
      );
      emit(ProfileActive(activeProfile: active, allProfiles: profiles));
    } catch (_) {
      emit(const ProfileError(message: 'Profile not found.'));
    }
  }

  // ── Update profile ────────────────────────────────────────
  Future<void> _onUpdate(
    ProfileUpdateEvent   event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileLoading());
    final result = await updateProfile(
      UpdateProfileParams(
        profileId:      event.profileId,
        name:           event.name,
        avatarUrl:      event.avatarUrl,
        isKids:         event.isKids,
        maturityRating: event.maturityRating,
      ),
    );
    result.fold(
      (failure) => emit(ProfileError(message: failure.message)),
      (profile) => emit(ProfileSaved(profile: profile)),
    );
  }

  // ── Create profile ────────────────────────────────────────
  Future<void> _onCreate(
    ProfileCreateEvent   event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileLoading());
    // TODO: wire to CreateProfileUseCase when built
    await Future.delayed(const Duration(milliseconds: 500));
    add(const ProfileFetchAllEvent());
  }

  // ── Delete profile ────────────────────────────────────────
  Future<void> _onDelete(
    ProfileDeleteEvent   event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileLoading());
    // TODO: wire to DeleteProfileUseCase when built
    await Future.delayed(const Duration(milliseconds: 500));
    if (state is ProfileListLoaded) {
      final remaining = (state as ProfileListLoaded)
          .profiles
          .where((p) => p.id != event.profileId)
          .toList();
      emit(ProfileDeleted(
        deletedId: event.profileId,
        remaining: remaining,
      ));
    }
  }

  // ── Switch mid-session ────────────────────────────────────
  Future<void> _onSwitch(
    ProfileSwitchEvent   event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileLoading());
    final result = await switchProfile(
      SwitchProfileParams(profileId: event.profileId),
    );
    result.fold(
      (failure) => emit(ProfileError(message: failure.message)),
      (profile) {
        final all = state is ProfileActive
            ? (state as ProfileActive).allProfiles
            : <ProfileEntity>[];
        emit(ProfileActive(activeProfile: profile, allProfiles: all));
      },
    );
  }
}