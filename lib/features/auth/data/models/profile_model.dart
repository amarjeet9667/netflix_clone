import '../../domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required super.id,
    required super.name,
    required super.avatar,
    required super.isKids,
    required super.maturityRating,
    required super.language,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] as String? ?? '',
      avatar: json['avatar'] as String? ?? '',
      isKids: json['isKids'] as bool? ?? false,
      maturityRating: json['maturityRating'] as String? ?? '',
      language: json['language'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatar': avatar,
      'isKids': isKids,
      'maturityRating': maturityRating,
      'language': language,
    };
  }
}
