// lib/features/user/domain/entities/user_account_entity.dart
import 'package:equatable/equatable.dart';

class UserAccountEntity extends Equatable {
  final int    id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String username;
  final String avatarUrl;

  const UserAccountEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.username,
    required this.avatarUrl,
  });

  String get fullName => '$firstName $lastName';

  @override
  List<Object?> get props =>
      [id, firstName, lastName, email, phone, username, avatarUrl];
}