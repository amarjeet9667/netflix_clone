// lib/features/search/domain/entities/genre_entity.dart
import 'package:equatable/equatable.dart';

class GenreEntity extends Equatable {
  final String id;
  final String name;
  final String icon; // emoji used as a lightweight visual

  const GenreEntity({
    required this.id,
    required this.name,
    required this.icon,
  });

  @override
  List<Object?> get props => [id, name, icon];
}