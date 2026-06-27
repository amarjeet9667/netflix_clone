// lib/features/home/domain/entities/home_section_entity.dart
import 'package:equatable/equatable.dart';

class HomeSectionEntity extends Equatable {
  final String                        id;
  final String                        title;
  final String                        type;
  final String                        displayStyle;
  // ✅ Fixed: List<Map<String, dynamic>> instead of List<dynamic>
  //    Gives type safety everywhere items are used in the UI
  final List<Map<String, dynamic>>    items;

  const HomeSectionEntity({
    required this.id,
    required this.title,
    required this.type,
    required this.displayStyle,
    required this.items,
  });

  factory HomeSectionEntity.fromJson(Map<String, dynamic> json) {
    // ✅ Safe cast: each element is already Map<String,dynamic> from DummyHomeSections
    final rawItems = json['items'] as List? ?? [];
    return HomeSectionEntity(
      id:           json['id']?.toString() ?? '',
      title:        json['title'] as String? ?? '',
      type:         json['type']  as String? ?? '',
      displayStyle: json['displayStyle'] as String? ?? '',
      items: rawItems
          .whereType<Map<String, dynamic>>()
          .toList(),
    );
  }

  @override
  List<Object?> get props => [id, title, type, displayStyle, items];
}