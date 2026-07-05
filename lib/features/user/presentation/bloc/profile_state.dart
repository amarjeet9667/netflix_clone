// lib/features/user/presentation/bloc/profile_state.dart
part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

/// All profiles loaded, none selected yet (who-is-watching screen)
class ProfileListLoaded extends ProfileState {
  final List<ProfileEntity> profiles;
  const ProfileListLoaded({required this.profiles});
  @override
  List<Object?> get props => [profiles];
}

/// A profile has been selected — app is ready to show content
class ProfileActive extends ProfileState {
  final ProfileEntity activeProfile;
  final List<ProfileEntity> allProfiles;
  const ProfileActive({required this.activeProfile, required this.allProfiles});
  @override
  List<Object?> get props => [activeProfile, allProfiles];
}

/// Profile saved successfully
class ProfileSaved extends ProfileState {
  final ProfileEntity profile;
  const ProfileSaved({required this.profile});
  @override
  List<Object?> get props => [profile];
}

/// Profile deleted successfully
class ProfileDeleted extends ProfileState {
  final String deletedId;
  final List<ProfileEntity> remaining;
  const ProfileDeleted({required this.deletedId, required this.remaining});
  @override
  List<Object?> get props => [deletedId, remaining];
}

class ProfileError extends ProfileState {
  final String message;
  const ProfileError({required this.message});
  @override
  List<Object?> get props => [message];
}
