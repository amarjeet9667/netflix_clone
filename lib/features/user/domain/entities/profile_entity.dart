// lib/features/user/domain/entities/profile_entity.dart
import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String id;
  final String name;
  final String avatarUrl;
  final bool isKids;
  final String maturityRating; // 'G' | 'PG-13' | 'R' | 'All Maturity Ratings'
  final String language;

  const ProfileEntity({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.isKids,
    required this.maturityRating,
    required this.language,
  });

  ProfileEntity copyWith({
    String? id,
    String? name,
    String? avatarUrl,
    bool? isKids,
    String? maturityRating,
    String? language,
  }) {
    return ProfileEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isKids: isKids ?? this.isKids,
      maturityRating: maturityRating ?? this.maturityRating,
      language: language ?? this.language,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    avatarUrl,
    isKids,
    maturityRating,
    language,
  ];
}
