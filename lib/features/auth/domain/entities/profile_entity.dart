import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String id;
  final String name;
  final String avatar;
  final bool isKids;
  final String maturityRating;
  final String language;

  const ProfileEntity({
    required this.id,
    required this.name,
    required this.avatar,
    required this.isKids,
    required this.maturityRating,
    required this.language,
  });

  @override
  List<Object?> get props => [id, name, avatar, isKids, maturityRating, language];
}
