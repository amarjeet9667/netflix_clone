// lib/features/player/domain/entities/subtitle_entity.dart
import 'package:equatable/equatable.dart';

class SubtitleEntity extends Equatable {
  final String language;     // e.g. 'English', 'Hindi'
  final String languageCode; // e.g. 'en', 'hi'
  final String? url;         // VTT/SRT URL (null = burned-in)

  const SubtitleEntity({
    required this.language,
    required this.languageCode,
    this.url,
  });

  @override
  List<Object?> get props => [language, languageCode, url];
}