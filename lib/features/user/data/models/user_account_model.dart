// lib/features/user/data/models/user_account_model.dart
import '../../domain/entities/user_account_entity.dart';

class UserAccountModel extends UserAccountEntity {
  const UserAccountModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.phone,
    required super.username,
    required super.avatarUrl,
  });

  factory UserAccountModel.fromDummyMap(Map<String, dynamic> map) {
    return UserAccountModel(
      id: map['id'] as int,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String? ?? '',
      username: map['username'] as String,
      avatarUrl: map['image'] as String? ?? '',
    );
  }

  factory UserAccountModel.fromJson(Map<String, dynamic> json) {
    return UserAccountModel(
      id: json['id'] as int,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String? ?? '',
      username: json['username'] as String,
      avatarUrl: json['image'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'phone': phone,
    'username': username,
    'image': avatarUrl,
  };
}
