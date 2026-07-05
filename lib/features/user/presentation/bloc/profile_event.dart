// lib/features/user/presentation/bloc/profile_event.dart
part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object?> get props => [];
}

/// Load all profiles for the account
class ProfileFetchAllEvent extends ProfileEvent {
  const ProfileFetchAllEvent();
}

/// Pick a profile to watch as
class ProfileSelectEvent extends ProfileEvent {
  final String profileId;
  const ProfileSelectEvent({required this.profileId});
  @override
  List<Object?> get props => [profileId];
}

/// Save edits to the active profile
class ProfileUpdateEvent extends ProfileEvent {
  final String profileId;
  final String name;
  final String? avatarUrl;
  final bool isKids;
  final String maturityRating;
  const ProfileUpdateEvent({
    required this.profileId,
    required this.name,
    this.avatarUrl,
    required this.isKids,
    required this.maturityRating,
  });
  @override
  List<Object?> get props => [
    profileId,
    name,
    avatarUrl,
    isKids,
    maturityRating,
  ];
}

/// Create a new profile
class ProfileCreateEvent extends ProfileEvent {
  final String name;
  final String? avatarUrl;
  final bool isKids;
  const ProfileCreateEvent({
    required this.name,
    this.avatarUrl,
    required this.isKids,
  });
  @override
  List<Object?> get props => [name, avatarUrl, isKids];
}

/// Delete a profile
class ProfileDeleteEvent extends ProfileEvent {
  final String profileId;
  const ProfileDeleteEvent({required this.profileId});
  @override
  List<Object?> get props => [profileId];
}

/// Switch to a different profile mid-session
class ProfileSwitchEvent extends ProfileEvent {
  final String profileId;
  const ProfileSwitchEvent({required this.profileId});
  @override
  List<Object?> get props => [profileId];
}
