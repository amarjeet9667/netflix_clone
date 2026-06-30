// lib/features/search/data/models/genre_model.dart
import '../../domain/entities/genre_entity.dart';

class GenreModel extends GenreEntity {
  const GenreModel({
    required super.id,
    required super.name,
    required super.icon,
  });

  factory GenreModel.fromDummyMap(Map<String, dynamic> map) {
    return GenreModel(
      id:   map['id'] as String,
      name: map['name'] as String,
      icon: map['icon'] as String,
    );
  }

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(
      id:   json['id'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String? ?? '🎬',
    );
  }
}