// lib/features/user/data/models/profile_model.dart
import '../../domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required super.id,
    required super.name,
    required super.avatarUrl,
    required super.isKids,
    required super.maturityRating,
    required super.language,
  });

  factory ProfileModel.fromDummyMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'] as String,
      name: map['name'] as String,
      avatarUrl: map['avatar'] as String,
      isKids: map['isKids'] as bool? ?? false,
      maturityRating:
          map['maturityRating'] as String? ?? 'All Maturity Ratings',
      language: map['language'] as String? ?? 'en',
    );
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] as String,
      name: json['name'] as String,
      avatarUrl: json['avatarUrl'] as String? ?? '',
      isKids: json['isKids'] as bool? ?? false,
      maturityRating:
          json['maturityRating'] as String? ?? 'All Maturity Ratings',
      language: json['language'] as String? ?? 'en',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'avatarUrl': avatarUrl,
    'isKids': isKids,
    'maturityRating': maturityRating,
    'language': language,
  };

  @override
  ProfileModel copyWith({
    String? id,
    String? name,
    String? avatarUrl,
    bool? isKids,
    String? maturityRating,
    String? language,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isKids: isKids ?? this.isKids,
      maturityRating: maturityRating ?? this.maturityRating,
      language: language ?? this.language,
    );
  }
}
