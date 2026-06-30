// lib/features/player/data/models/subtitle_model.dart
import '../../domain/entities/subtitle_entity.dart';

class SubtitleModel extends SubtitleEntity {
  const SubtitleModel({
    required super.language,
    required super.languageCode,
    super.url,
  });

  factory SubtitleModel.fromJson(Map<String, dynamic> json) {
    return SubtitleModel(
      language: json['language'] as String,
      languageCode: json['languageCode'] as String,
      url: json['url'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'language': language,
    'languageCode': languageCode,
    'url': url,
  };

  /// Default subtitle options used in dummy / test env
  static List<SubtitleModel> get defaults => const [
    SubtitleModel(language: 'English', languageCode: 'en'),
    SubtitleModel(language: 'Hindi', languageCode: 'hi'),
    SubtitleModel(language: 'Spanish', languageCode: 'es'),
    SubtitleModel(language: 'French', languageCode: 'fr'),
    SubtitleModel(language: 'Korean', languageCode: 'ko'),
  ];
}
